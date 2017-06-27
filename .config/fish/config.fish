if status --is-login
  set PPID (echo (ps --pid %self -o ppid --no-headers) | xargs)
  if ps --pid $PPID | grep ssh
    tmux has-session -t remote; and tmux attach-session -t remote; or tmux new-session -s remote; and kill %self
    echo "tmux failed to start; using plain fish shell"
  end
end

[ -e ~/.dircolors ]; and eval (dircolors -b ~/.dircolors)
dir_colors ~/.dircolors.ansi-dark
set -x SHELL (which fish)
