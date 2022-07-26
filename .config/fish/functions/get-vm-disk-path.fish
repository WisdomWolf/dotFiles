function get-vm-disk-path
    set vm_name $argv
    set disk_path (virsh dumpxml $vm_name | grep 'source file' | awk -F\' '{print $2}')
    set disk_path (string replace '/mnt/user' '/mnt/unraid' $disk_path)
    echo $disk_path
end
