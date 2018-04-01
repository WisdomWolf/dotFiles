# Defined in - @ line 1
function get-micro
	set micro_version (curl https://api.github.com/repos/zyedidia/micro/releases/latest | jq -r '.name')
    if string match -rq '_64' (uname -m)
        set platform '64'
    else if string match -rq 'arm' (uname -m)
        set platform '-arm'
    else
        echo 'unknown platform: ' (uname -m)
        return 1
    end
    wget https://github.com/zyedidia/micro/releases/download/v$micro_version/micro-$micro_version-linux$platform.tar.gz
end
