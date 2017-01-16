function exit_test --description 'make exiter work with both screen and tmux'
	if set -q TMUX
or set -q STY
echo -e "found either screen or tmux"
else
echo -e "no terminal multiplexer found"
end
end
