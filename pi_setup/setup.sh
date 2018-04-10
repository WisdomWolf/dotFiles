#!/bin/bash

[ "$UID" -eq 0 ] || exec sudo -E "$0" "$@"

if ! [ -x "$(command -v node)" ]; then
	curl -sL https://deb.nodesource.com/setup_8.x | bash -
else
	echo "skipping node install"
fi
apt update
apt install -y fish tmux vim curl wget git httpie jq sed nodejs neovim \
python python3 python-dev python3-dev python-pip python3-pip make buildessential \
libssel-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev
if ! [ -e $HOME/.config/fish/functions/fisher.fish ]; then
	echo "Downloading fisher"
	curl -Lo $HOME/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
else
	echo "skipping fisher install"
fi
if ! [ -x "$(command -v yadm)" ]; then
	echo "Downloading yadm"
	curl -fLo /usr/local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x /usr/local/bin/yadm
else
	echo "skipping yadm install"
fi

chown -R $SUDO_USER:$SUDO_USER $HOME
raspi-config nonint do_boot_behaviour B2

# set keyboard to US
sed -i "s/XKBLAYOUT=\"gb\"/XKBLAYOUT=\"us\"/" /etc/default/keyboard

# reboot for changes to take effect
reboot now
