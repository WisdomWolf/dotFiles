# Defined in - @ line 0
function dps --description alias\ dps=docker\ ps\ --format\ \"table\ \{\{.Image\}\}\\t\{\{.Names\}\}\\t\{\{.CreatedAt\}\}\\t\{\{.Status\}\}\"
	docker ps --format "table {{.Image}}\t{{.Names}}\t{{.CreatedAt}}\t{{.Status}}" $argv;
end
