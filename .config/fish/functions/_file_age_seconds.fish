function _file_age_seconds
    set filepath $argv[1]

    if stat --version >/dev/null 2>&1
        # GNU stat (Linux, or Homebrew coreutils shadowing /usr/bin/stat on macOS)
        stat -c %Y $filepath
    else
        # BSD stat (macOS default /usr/bin/stat, or other BSD-likes)
        stat -f %m $filepath
    end
end