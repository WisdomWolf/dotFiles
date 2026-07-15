function new-uv-project
    mkdir $argv[1] && cd $argv[1]
    uv init
    uv venv
    echo 'export VIRTUAL_ENV="$PWD/.venv"
export PATH="$VIRTUAL_ENV/bin:$PATH"' > .envrc
    direnv allow
    xattr -w com.dropbox.ignored 1 .venv
end
