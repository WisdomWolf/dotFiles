bind -e \cs
if status --is-login
    # Exclude running on macOS
    and string match -rqv Darwin (uname)
    set PPID (echo (ps --pid %self -o ppid --no-headers) | xargs)
    if ps --pid $PPID | grep ssh
        or ps --pid $PPID | grep mosh
        set SESSION_NAME "*"(hostname -s)
        tmux has-session -t $SESSION_NAME
        and tmux attach-session -t $SESSION_NAME
        or tmux new-session -s $SESSION_NAME
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

function is-mac
    if string match -rq Darwin (uname -a)
        echo true
        return 0
    else
        echo false
        return 1
    end
end

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
if test (is-mac) = false
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
            if status --is-interactive
                echo "testing identities" | ts >> ssh_agent.log
            else
                echo "skipping identity test" | ts >> ssh_agent.log
            end
            test_identities
        else
    #        start_agent
            if status --is-interactive
                echo "starting agent" | ts >> ~/ssh_agent.log
                start_agent
            else
                echo "non-interactive session" | ts >> ~/ssh_agent.log
            end
        end
    end
end

# function test_identities
#     ssh-add -l | grep "The agent has no identities" >/dev/null
#     if [ $status -eq 0 ]
#         ssh-add
#         if [ $status -eq 2 ]
#             start_agent
#         end
#     end
# end


if test \( -e $HOME/.pyenv/bin/pyenv \) -o \( -e /usr/local/bin/pyenv \)
    if not contains "$HOME/.pyenv/bin" $fish_user_paths
        set -Up fish_user_paths $HOME/.pyenv/bin
    end
    status --is-interactive; and pyenv init --path | source
    status --is-interactive; and pyenv init - | source
    status --is-interactive; and pyenv virtualenv-init - | source

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
if type -q starship
    starship init fish | source
end

# Used by pipx
if test (version $FISH_VERSION) -gt (version 3.2)
    fish_add_path $HOME/.local/bin
else
    if not contains "$HOME/.local/bin" $fish_user_paths
        set -Ua fish_user_paths $HOME/.local/bin
    end
end

if test -e ~/google-cloud-sdk/path.fish.inc
    and not contains ~/google-cloud-sdk/bin $PATH
    source ~/google-cloud-sdk/path.fish.inc
end
