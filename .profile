export PATH="$(brew --prefix)/bin:$PATH"


source ~/.xsh

case $- in
    *i*)
        # Interactive session.  Try switching to fish.
        if [ -z "$FISH_VERSION" ]; then # do nothing if running under fish already
            fish=$(command -v fish)
            if [ -x "$fish" ]; then
                export SHELL="$fish"
                exec "$fish"
            fi
        fi
esac

