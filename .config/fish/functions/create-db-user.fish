function create-db-user
    argparse \
                'h/help' \
                'd/database=' \
                'p/password=' \
                't/target=' \
                -- $argv
    or return 1
    
    if set -q _flag_help; or test (count $argv) -lt 1
        echo "Usage: create-db-user <username> [-d database] [-p password] [-t mysql|postgres|both]"
        echo "  -d, --database  Database name (defaults to username)"
        echo "  -p, --password  Password (generated if not provided)"
        echo "  -t, --target    Target database: mysql, postgres, or both (default: both)"
        return 0
    end
    
    set username $argv[1]
    set dbname (if set -q _flag_database; echo $_flag_database; else; echo $username; end)
    set password (if set -q _flag_password; echo $_flag_password; else; generate-passphrase; end)
    set target (if set -q _flag_target; echo $_flag_target; else; echo "both"; end)
    
    echo "Creating user=$username db=$dbname target=$target"
    
    if test $target = mysql -o $target = both
        mysql -u root -p -e "
            CREATE DATABASE IF NOT EXISTS \`$dbname\`;
            CREATE USER IF NOT EXISTS '$username'@'%' IDENTIFIED BY '$password';
            GRANT ALL PRIVILEGES ON \`$dbname\`.* TO '$username'@'%';
            FLUSH PRIVILEGES;
        "
    end
    
    if test $target = postgres -o $target = both
        psql -U postgres -c "CREATE DATABASE $dbname;" 2>/dev/null
        psql -U postgres -c "CREATE USER $username WITH PASSWORD '$password';" 2>/dev/null
        psql -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE $dbname TO $username;" 2>/dev/null
    end
    
    echo "Done. Save these credentials:"
    echo "  Username: $username"
    echo "  Database: $dbname"
    echo "  Password: $password"
end
