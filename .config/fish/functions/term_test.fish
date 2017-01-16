function term_test --description 'trap exit calls from screen/tmux'
	if test -a (set -q TMUX) (set -q STY)
        echo -e "\nDon't exit from screen.  Detach with Ctrl+A thend D"
        echo -e "Alternatively, you can force disconnection with: <Return>~.\n"
    else
        echo "No special terminals found"
    end
end
