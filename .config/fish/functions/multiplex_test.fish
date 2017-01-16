function multiplex_test
	if test -n "$TMUX" -o "$STY"
echo 'seem to be running in tmux or screen'
else
echo 'direct shell running'
end
end
