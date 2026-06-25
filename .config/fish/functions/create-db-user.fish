function create-db-user
    argparse \
                'h/help' \
                'd/database=' \
                'p/password=' \
                'u/uri=' \
                'n/op-item-name=' \
                'a/admin-op-item=' \
                -- $argv
    or return 1
    
    if set -q _flag_help; or test (count $argv) -lt 1
        echo "Usage: create-db-user <username> [-d database] [-p password] [-u uri] [-n op-item-name] [-a admin-op-item]"
        echo "  -d, --database        Database name (defaults to username)"
        echo "  -p, --password        Password (generated if not provided)"
        echo "  -u, --uri             Connection URI (e.g. postgresql://admin@host:5432/postgres)"
        echo "  -n, --op-item-name    1Password item name for new credentials (defaults to <username>-db)"
        echo "  -a, --admin-op-item   1Password item name for admin credentials (defaults to mariadb-admin or postgres-admin)"
        return 0
    end
    
    set username $argv[1]
    set dbname (if set -q _flag_database; echo $_flag_database; else; echo $username; end)
    set op_item_name (if set -q _flag_op_item_name; echo $_flag_op_item_name; else; echo "$username-db"; end)
    
    if not set -q _flag_uri
        echo "Error: --uri is required" >&2
        return 1
    end
    
    if string match -q 'postgresql://*' $_flag_uri; or string match -q 'postgres://*' $_flag_uri
        set db_tag postgresql
        set default_admin_op_item postgres-admin
        
        # Parse URI
        set uri_stripped (string replace -r '^(postgresql|postgres)://' '' $_flag_uri)
        set userinfo (string split '@' $uri_stripped)[1]
        set hostinfo (string split '@' $uri_stripped)[2]
        
        # Check if password is in URI
        if string match -q '*:*' $userinfo
            # Password in URI — use as-is
            set pg_uri $_flag_uri
        else
            # No password in URI — resolve from env or 1Password
            if not set -q PGPASSWORD
                set admin_op_item (if set -q _flag_admin_op_item; echo $_flag_admin_op_item; else; echo $default_admin_op_item; end)
                set -fx PGPASSWORD (op item get $admin_op_item --vault Homelab --fields password --reveal)
                or begin
                    echo "Error: could not retrieve admin password from 1Password item '$admin_op_item'" >&2
                    return 1
                end
            end
            set db_user $userinfo
            set pg_uri "postgresql://$db_user@$hostinfo"
        end
        
        # Check if user already exists
        if psql $pg_uri -tAc "SELECT 1 FROM pg_roles WHERE rolname='$username';" | grep -q 1
            echo "Error: user '$username' already exists in PostgreSQL" >&2
            return 1
        end
        
        set password (if set -q _flag_password; echo $_flag_password; else; generate-passphrase; end)
        
        psql $pg_uri -c "CREATE DATABASE $dbname;" 2>/dev/null
        psql $pg_uri -c "CREATE USER $username WITH PASSWORD '$password';" 2>/dev/null
        psql $pg_uri -c "GRANT ALL PRIVILEGES ON DATABASE $dbname TO $username;" 2>/dev/null
        psql $pg_uri -c "GRANT USAGE ON SCHEMA public to $username;" 2>/dev/null
        psql $pg_uri -c "GRANT CREATE ON SCHEMA public to $username;" 2>/dev/null
        
    else if string match -q 'mysql://*' $_flag_uri; or string match -q 'mariadb://*' $_flag_uri
        set db_tag mariadb
        set default_admin_op_item mariadb-admin
        
        # Parse URI
        set uri_stripped (string replace -r '^(mysql|mariadb)://' '' $_flag_uri)
        set userinfo (string split '@' $uri_stripped)[1]
        set hostinfo (string split '@' $uri_stripped)[2]
        set host (string split ':' $hostinfo)[1]
        set port_and_db (string split ':' $hostinfo)[2]
        set port (string split '/' $port_and_db)[1]
        
        # Check if password is in URI
        if string match -q '*:*' $userinfo
            set db_user (string split ':' $userinfo)[1]
            set db_pass (string split ':' $userinfo)[2]
            set mariadb_args -h $host -P $port -u $db_user -p$db_pass
        else
            set db_user $userinfo
            if not set -q MYSQL_PWD
                set admin_op_item (if set -q _flag_admin_op_item; echo $_flag_admin_op_item; else; echo $default_admin_op_item; end)
                set -fx MYSQL_PWD (op item get $admin_op_item --vault Homelab --fields password --reveal)
                or begin
                    echo "Error: could not retrieve admin password from 1Password item '$admin_op_item'" >&2
                    return 1
                end
            end
            set mariadb_args -h $host -P $port -u $db_user
        end
        
        # Check if user already exists
        if mariadb $mariadb_args -e "SELECT User FROM mysql.user WHERE User='$username';" | grep -q $username
            echo "Error: user '$username' already exists in MariaDB" >&2
            return 1
        end
        
        set password (if set -q _flag_password; echo $_flag_password; else; generate-passphrase; end)
        
        printf 'CREATE DATABASE IF NOT EXISTS `%s`;\nCREATE USER IF NOT EXISTS `%s`@`%%` IDENTIFIED BY "%s";\nGRANT ALL PRIVILEGES ON `%s`.* TO `%s`@`%%`;\nFLUSH PRIVILEGES;\n' \
                        $dbname $username $password $dbname $username \
                        | mariadb $mariadb_args
        
    else
        echo "Error: unrecognized URI scheme, expected postgresql://, postgres://, mysql://, or mariadb://" >&2
        return 1
    end
    
    echo ""
    echo "Done. Credentials:"
    echo "  Username: $username"
    echo "  Database: $dbname"
    echo "  Password: $password"
    
    echo ""
    read -l -P "Save credentials to 1Password as '$op_item_name'? [y/N] " confirm
    if string match -qi 'y' $confirm
        if op item get $op_item_name --vault Homelab 2>/dev/null
            op item edit $op_item_name \
                                --vault Homelab \
                                --tags $db_tag \
                                "username[text]=$username" \
                                "password=$password" \
                                "database[text]=$dbname"
            and echo "Updated existing 1Password item '$op_item_name'"
            or echo "Failed to update 1Password item" >&2
        else
            op item create \
                                --category password \
                                --vault Homelab \
                                --title $op_item_name \
                                --tags $db_tag \
                                "username[text]=$username" \
                                "password=$password" \
                                "database[text]=$dbname"
            and echo "Saved to 1Password as '$op_item_name'"
            or echo "Failed to save to 1Password" >&0
        end
    end
end
