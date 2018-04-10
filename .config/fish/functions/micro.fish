function micro --description 'alias micro=snap run micro'
	if type -q snap
        snap run micro $argv
    else
        set micro_ (which micro)
        if test -n "$micro_"
            eval "$micro_ $argv"
        else
            printf "Micro doesn't appear to be installed"
        end
    end
end
