# Defined in /tmp/fish.GIeg5y/topten.fish @ line 2
function topten
	get-dir-sizes $argv | head -n10
end
