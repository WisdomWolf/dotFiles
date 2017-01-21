function ssh!
	ssh -o ConnectionAttempts=10 -o ConnectTimeout=180 $argv[1]
end
