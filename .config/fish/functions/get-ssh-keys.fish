function get-ssh-keys
	if sudo test -e /home/ssh-dummy/.ssh/authorized_keys
		sudo cat /home/ssh-dummy/.ssh/authorized_keys >> ~/.ssh/authorized_keys
		echo 'Keys copied successfully!'
		sudo rm /home/ssh-dummy/.ssh/authorized_keys
		echo 'Cleanup completed.'
	else
		echo 'Authorized keys file not found, assuming that keys have already been copied.'
	end
end
