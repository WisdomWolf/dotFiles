export PATH="$(brew --prefix)/bin:$PATH"


source ~/.xsh

if [ -e /home/wisdomwolf/.nix-profile/etc/profile.d/nix.sh ]; then . /home/wisdomwolf/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
