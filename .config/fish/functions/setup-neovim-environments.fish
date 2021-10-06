# Defined in /tmp/fish.aoxen1/setup-neovim-environments.fish @ line 1
function setup-neovim-environments
    pyenv update
    # Ensure nvim file exists
    mkdir -p ~/.config/nvim
    touch ~/.config/nvim/custom.vim
    # Delete existing variables from custom.vim
    sed -i -r 's/.*python3?_host_prog.*$//' ~/.config/nvim/custom.vim
    for env in neovim2 neovim3
        if test (string match -r '2' "$env")
            set python_version 2.7.18
        else
            set python_version (pyenv-latest)
            set suffix 3
        end
        # Create and activate venv
        pyenv install --skip-existing $python_version
        pyenv virtualenv $python_version $env
        pyenv activate $env
        # Install pynvim package in venv
        pip install -U pip
        pip install pynvim
        set nvim_path (pyenv which python)
        # Add variables pointing to venv path to custom.vim
        echo "let g:python"$suffix"_host_prog = '$nvim_path'" >> ~/.config/nvim/custom.vim
    end
    pip install flake8
    sudo ln -s (pyenv which flake8) ~/bin/flake8
    pyenv deactivate
end
