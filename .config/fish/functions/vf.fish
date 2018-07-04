# Defined in /tmp/fish.BoHUZb/vf.fish @ line 2
function vf
	set arg_count (count $argv)
    if test $arg_count -gt 1
        set base_version $argv[1]
        set env_name $argv[2]
        pyenv virtualenv $base_version $env_name
    else
        set env_name $argv[1]
        pyenv virtualenv $env_name
    end
    pyenv local $env_name
end
