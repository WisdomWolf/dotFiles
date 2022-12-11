function kube-vip --wraps='docker run --network host --rm ghcr.io/kube-vip/kube-vip:' --description 'alias kube-vip=docker run --network host --rm ghcr.io/kube-vip/kube-vip:'
  docker run --network host --rm ghcr.io/kube-vip/kube-vip: $argv; 
end
