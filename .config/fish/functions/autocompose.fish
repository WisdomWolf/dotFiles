function autocompose
	cd ~/Dropbox/GitHub/docker-autocompose
mkdir -p "$argv"
python autocompose.py "$argv" > "$argv/docker-compose.yml"
back
end
