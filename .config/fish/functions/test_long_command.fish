function test_long_command
	if test -z "$argv"
		set sleep_time 15
	else
		set sleep_time $argv[1]
	end
	echo starting long command with "$sleep_time"s delay...
	sleep $sleep_time
	echo 'DONE!'
end
