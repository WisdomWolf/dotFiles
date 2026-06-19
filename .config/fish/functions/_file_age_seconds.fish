function _file_age_seconds
    set filepath $argv[1]
    
    switch (uname)
        case Linux
            stat -c %Y $filepath
        case Darwin
            stat -f %m $filepath
        case '*'
            # Fallback — assume stale if we can't determine age
                        echo 0
        end
end
