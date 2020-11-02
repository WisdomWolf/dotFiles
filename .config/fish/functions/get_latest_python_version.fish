function get_latest_python_version
 pyenv install --list | grep -E '\s3\.[[:digit:]]\.[[:digit:]]+$' | tail -n 1 | string trim
end
