function vf_deactivated --on-event virtualenv_did_deactivate
	echo "The virtualenv" (basename $VIRTUAL_ENV) "was deactivated!"
end
