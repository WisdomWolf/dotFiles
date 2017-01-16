function hass-update-config
	cd ~/hass_config; and git pull; and cp -R * ~/.homeassistant/; and prevd $argv;
end
