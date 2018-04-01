function get-micro
	set micro_version (curl https://api.github.com/repos/zyedidia/micro/releases/latest | jq -r '.name')
wget https://github.com/zyedidia/micro/releases/download/v$micro_version/micro-$micro_version-linux-arm.tar.gz
end
