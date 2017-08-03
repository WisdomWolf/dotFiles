function vf_new
	vf new $argv
vf connect
vf deactivate
set current_dir (eval pwd)
cd .
cd $current_dir
end
