function vf_activated --description 'alert when virtual environment activated' --on-event virtualenv_did_activate
	echo "The virtualenv" (basename $VIRTUAL_ENV) "was activated"
end
