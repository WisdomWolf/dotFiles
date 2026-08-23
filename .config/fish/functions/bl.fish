function bl
    if test -d $argv[1]
        la $argv
    else
        bat $argv
    end
end
