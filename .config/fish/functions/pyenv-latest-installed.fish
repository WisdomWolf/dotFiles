function pyenv-latest-installed
pyenv versions | grep -E '\s3\.[[:digit:]]+\.[[:digit:]]+$' | sort -V | tail -n 1 | string trim
end
