# Defined in /tmp/fish.QAtlNc/exiter.fish @ line 2
function exiter --description 'trap exit calls in tmux or screen'
	if test -n "$TMUX";
    or test -n "$STY"
        echo "Detach with command + d or use ~. to directly disconnect"
    else
        builtin exit
    end
end
