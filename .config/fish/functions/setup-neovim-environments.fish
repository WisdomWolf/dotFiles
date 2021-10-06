# Defined in /tmp/fish.DmbF7l/setup-neovim-environments.fish @ line 2
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
        echo "Ensuring $env virtualenv exists"
        pyenv install --skip-existing $python_version
        pyenv virtualenv $python_version $env
        pyenv activate $env
        # Install pynvim package in venv
        echo "Installing latest pynvim package in virtual environment"
        pip install --upgrade pip
        pip install --upgrade pynvim
        set nvim_path (pyenv which python)
        # Add variables pointing to venv path to custom.vim
        echo "Adding virtualenv paths to custom.vim file"
        echo "let g:python"$suffix"_host_prog = '$nvim_path'" | tee -a ~/.config/nvim/custom.vim
    end
    pip install flake8
    sudo ln -s (pyenv which flake8) ~/bin/flake8
    pyenv deactivate
end
