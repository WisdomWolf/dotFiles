function docker-restart-service --description 'restart replicated docker service'
	set current_replicas (docker service inspect $argv | jq '.[].Spec.Mode.Replicated.Replicas')
if test $current_replicas -gt 0
docker service scale $argv=0; and docker service scale $argv=$current_replicas
else
echo "Unable to restart $argv because it either doesn't exist or isn't running in replica mode"
end
end
