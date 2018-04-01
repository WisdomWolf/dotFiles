# Defined in /tmp/fish.YEE3Vp/tardir.fish @ line 2
function tardir
	set name "$argv[1]"
    if test -d $name
        if count $argv > 1
            set filename "$name-$argv[2..-1].tgz"
        else
            set filename "$name.tgz"
        end
        tar -czf $filename $name
        if test -e $filename
            rm -r $name
            echo "removed $name/ successfully"
        end
            echo "tgz created for $name successfully"
    else
        printf 'Invalid directory specified: %s' $name
    end
end
