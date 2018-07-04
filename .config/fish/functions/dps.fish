# Defined in /tmp/fish.RF7RPl/dps.fish @ line 2
function dps --description alias\ dps=docker\ ps\ --format\ \"table\ \{\{.Image\}\}\\t\{\{.Names\}\}\\t\{\{.CreatedAt\}\}\\t\{\{.Status\}\}\"
	docker ps --format "table {{.Names}}\t{{.Image}}\t{{.CreatedAt}}\t{{.Status}}" $argv;
end
