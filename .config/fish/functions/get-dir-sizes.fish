# Defined in /tmp/fish.kX3KCk/get-dir-sizes.fish @ line 2
function get-dir-sizes
	if test (count $argv) -ge 1
        set dir $argv[1]
    else
        set dir '.'
    end
	du -d1 -h $dir 2>&1 | sed '/Permission denied/d;' | sort -hr
end
