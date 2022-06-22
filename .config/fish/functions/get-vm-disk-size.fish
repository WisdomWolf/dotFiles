function get-vm-disk-size
set disk_path $argv
set disk_size (la $disk_path | awk '{print $5}')
echo $disk_size
end
