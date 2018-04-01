#!/bin/bash

[ "$UID" -eq 0 ] || exec sudo -E "$0" "$@"

if ! [ -x "$(command -v node)" ]; then
	curl -sL https://deb.nodesource.com/setup_8.x | bash -
else
	echo "skipping node install"
fi
apt update
apt install -y fish tmux vim curl wget git httpie jq sed nodejs neovim
if ! [ -e $HOME/.config/fish/functions/fisher.fish ]; then
	echo "Downloading fisher"
	curl -Lo $HOME/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
	chown -R $SUDO_USER:$SUDO_USER $HOME/.config/fish/functions
else
	echo "skipping fisher install"
fi
if ! [ -x "$(command -v yadm)" ]; then
	echo "Downloading yadm"
	curl -fLo /usr/local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x /usr/local/bin/yadm
else
	echo "skipping yadm install"
fi

# set keyboard to US
sed -i "s/XKBLAYOUT=\"gb\"/XKBLAYOUT=\"us\"/" /etc/default/keyboard
# reboot for changes to take effect
reboot now
