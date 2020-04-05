function pyenv-latest
pyenv install --list | grep -E '\s3\.[[:digit:]]+\.[[:digit:]]+$' | tail -n 1 | string trim
end
