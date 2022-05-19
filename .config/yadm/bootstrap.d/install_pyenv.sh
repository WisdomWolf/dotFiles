#!/usr/bin/env bash
script_dir=`dirname "$0"`

# Install prereqs
bash $script_dir/install_pyenv_prereqs.sh

# Install Pyenv
if [[ ! -d $HOME/.pyenv ]]; then
    curl https://pyenv.run | bash
else
    echo "Pyenv appears to be installed already"
fi
