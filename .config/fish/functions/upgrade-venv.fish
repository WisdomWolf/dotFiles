function upgrade-venv
	set $new_version $argv[1]
set venv_name (pyenv version-name)
pip freeze > .pyenv_requirements.txt
pyenv uninstall $venv_name
pyenv virtualenv $new_version $venv_name
pyenv local $venv_name
pip install -U pip
pip install -r .pyenv_requirements.txt
echo "upgrade to $new_version completed successfully."
end
