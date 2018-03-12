function vf
	set arg_count (count $argv)
if test $arg_count -gt 1
set base_version "$argv[1] "
set env_name "$argv[2]"
else
set base_version ""
set env_name "$argv"
end
pyenv virtualenv $base_version$env_name
pyenv local $env_name
end
