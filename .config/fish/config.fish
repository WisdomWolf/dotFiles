bind -e \cs
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
    source $SSH_ENV >/dev/null
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

if test -n "$WSL_DISTRO_NAME"
#     set -x SSH_AUTH_SOCK $HOME/.ssh/agent.sock
#     ss -a | grep -q $SSH_AUTH_SOCK
#     if [ $status != 0 ]
#         rm -f $SSH_AUTH_SOCK
#         setsid nohup socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:$HOME/.ssh/wsl2-ssh-pageant.exe >/dev/null 2>&1 &
#     end
    set -Ux DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
end
if [ -n "$SSH_AGENT_PID" ]
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent >/dev/null
    if [ $status -eq 0 ]
        test_identities
    end
else
    if [ -f $SSH_ENV ]
        source $SSH_ENV >/dev/null
    end
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent >/dev/null
    if [ $status -eq 0 ]
        test_identities
    else
        start_agent
    end
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


if test -e $HOME/.pyenv/bin/pyenv
    if not contains "$HOME/.pyenv/bin" $fish_user_paths
        set -x fish_user_paths $HOME/.pyenv/bin $fish_user_paths
    end
    status --is-interactive; and source (pyenv init --path | source)
    status --is-interactive; and pyenv init - | source
    status --is-interactive; and source (pyenv virtualenv-init -|psub)

    #pyenv-virtualenv init
    set -ga fish_user_paths '/usr/local/Cellar/pyenv-virtualenv/1.1.5/shims'
    set -gx PYENV_VIRTUALENV_INIT 1;
    function _pyenv_virtualenv_hook --on-event fish_prompt
    set -l ret $status
    if [ -n "$VIRTUAL_ENV" ]
        pyenv activate --quiet; or pyenv deactivate --quiet; or true
    else
        pyenv activate --quiet; or true
    end
    return $ret
    end
end
# source ~/.config/extraterm/commands/setup_extraterm_fish.fish

#if not functions -q fisher
#    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
#    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
#end
starship init fish | source
