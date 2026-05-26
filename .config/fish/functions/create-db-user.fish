function create-db-user
    argparse \
                'h/help' \
                'd/database=' \
                'p/password=' \
                'u/uri=' \
                -- $argv
    or return 1
    
    if set -q _flag_help; or test (count $argv) -lt 1
        echo "Usage: create-db-user <username> [-d database] [-p password] [-u uri]"
        echo "  -d, --database  Database name (defaults to username)"
        echo "  -p, --password  Password (generated if not provided)"
        echo "  -u, --uri       Connection URI (e.g. postgresql://admin:pass@host:5432/postgres)"
        return 0
    end
    
    set username $argv[1]
    set dbname (if set -q _flag_database; echo $_flag_database; else; echo $username; end)
    set password (if set -q _flag_password; echo $_flag_password; else; generate-passphrase; end)
    
    if not set -q _flag_uri
        echo "Error: --uri is required" >&2
        return 1
    end
    
    if string match -q 'postgresql://*' $_flag_uri; or string match -q 'postgres://*' $_flag_uri
        psql $_flag_uri -c "CREATE DATABASE $dbname;" 2>/dev/null
        psql $_flag_uri -c "CREATE USER $username WITH PASSWORD '$password';" 2>/dev/null
        psql $_flag_uri -c "GRANT ALL PRIVILEGES ON DATABASE $dbname TO $username;" 2>/dev/null
    else if string match -q 'mysql://*' $_flag_uri; or string match -q 'mariadb://*' $_flag_uri
        mysql $_flag_uri -e "CREATE DATABASE IF NOT EXISTS \`$dbname\`;"
        mysql $_flag_uri -e "CREATE USER IF NOT EXISTS '$username'@'%' IDENTIFIED BY '$password';"
        mysql $_flag_uri -e "GRANT ALL PRIVILEGES ON \`$dbname\`.* TO '$username'@'%';"
        mysql $_flag_uri -e "FLUSH PRIVILEGES;"
    else
        echo "Error: unrecognized URI scheme, expected postgresql://, postgres://, mysql://, or mariadb://" >&2
        return 1
    end
    
    echo "Done. Save these credentials:"
    echo "  Username: $username"
    echo "  Database: $dbname"
    echo "  Password: $password"
end
