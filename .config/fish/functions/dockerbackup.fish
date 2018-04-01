function dockerbackup
	docker run --rm --volumes-from $argv[1] -v (pwd):/backup ubuntu tar cvf /backup/$argv[2] $argv[3]
end
