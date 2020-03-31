function watchtowerrr
	set containers $argv
docker pull containrrr/watchtower:latest
docker run --rm \
-v /var/run/docker.sock:/var/run/docker.sock \
containrrr/watchtower \
--run-once \
$containers
echo 'The watchers on the wall have ended their service'
end
