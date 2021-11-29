#!/usr/bin/env bash
script_dir=`dirname "$0"`

# Install prereqs
bash $script_dir/install_pyenv_prereqs.sh

# Install Pyenv
curl https://pyenv.run | bash
