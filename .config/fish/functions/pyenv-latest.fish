function pyenv-latest
    set -l options (fish_opt --short=i --long=installed --long-only)
    argparse --ignore-unknown $options -- $argv
    if test -z "$_flag_installed"
        set cmd 'pyenv install --list'
    else
        set cmd 'pyenv versions'
    end
    if test (count $argv) -gt 0
        set _version (string replace '.' '\.' $argv)
        set pattern "^\s+$_version"
    else
        set pattern '\s3\.[[:digit:]]+\.[[:digit:]]+$'
    end
    eval $cmd | grep -E "$pattern" | sort -V | tail -n 1 | string trim
end
