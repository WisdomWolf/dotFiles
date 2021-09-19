# Defined in /tmp/fish.T0IV3I/yadm-add-function.fish @ line 2
function yadm-add-function
    for arg in $argv
        set func_path ~/.config/fish/functions/$arg.fish
        if test -e $func_path
            echo "adding $func_path to yadm"
            yadm add $func_path
        else
            echo "Skipping $arg because the function doesn't appear to exist at $func_path"
        end
    end
end
