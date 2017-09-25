if status --is-login
    set PPID (echo (ps --pid %self -o ppid --no-headers) | xargs)
    if ps --pid $PPID | grep ssh
        or ps --pid $PPID | grep mosh
        tmux has-session -t remote
        and tmux attach-session -t remote
        or tmux new-session -s remote
        and kill %self
        echo "tmux failed to start; using plain fish shell"
    end
end

#[ -e ~/.dircolors ]; and eval (dircolors -b ~/.dircolors)
dir_colors ~/.dircolors.ansi-dark
set -x SHELL (which fish)

# content has to be in .config/fish/config.fish
# if it does not exist, create the file
setenv SSH_ENV $HOME/.ssh/environment

function start_agent
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' >$SSH_ENV
    echo "succeeded"
    chmod 600 $SSH_ENV
    . $SSH_ENV >/dev/null
    ssh-add
end

function test_identities
    ssh-add -l | grep "The agent has no identities" >/dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end

if [ -n "$SSH_AGENT_PID" ]
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent >/dev/null
    if [ $status -eq 0 ]
        test_identities
    end
else
    if [ -f $SSH_ENV ]
        . $SSH_ENV >/dev/null
    end
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent >/dev/null
    if [ $status -eq 0 ]
        test_identities
    else
        start_agent
    end
end

if test -e $HOME/.pyenv/bin/pyenv
    set -x fish_user_paths $HOME/.pyenv/bin $fish_user_paths
    status --is-interactive; and . (pyenv init -|psub)
    status --is-interactive; and . (pyenv virtualenv-init -|psub)
else
    echo "pyenv doesn't appear to be installed"
end
