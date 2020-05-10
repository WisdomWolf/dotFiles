function pyenv-version-match
	set pattern (string replace '.' '\.' $argv)
pyenv install --list | grep -E "^\s+$pattern" | tail -n 1 | string trim
end
