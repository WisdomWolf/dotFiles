function copy-k3s-config
set node_ip 192.168.30.245
set cluster_vip 192.168.30.3
rsync -avz rancher@$node_ip:/etc/rancher/k3s/k3s.yaml ~/k3os-vip.yaml && chmod 700 ~/k3os-vip.yaml && sed -i "s/127.0.0.1/$cluster_vip/" ~/k3os-vip.yaml
end
