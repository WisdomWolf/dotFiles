function generate_random_string
	cat /dev/urandom|fold -w 120|head -n 1|base64 -w 0|tr -dc '0-9A-Za-z'|cut -c -80
end
