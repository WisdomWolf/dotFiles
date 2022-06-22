function recreate-vm
    set -l options (fish_opt --short=y --long=confirm)
    set -la options (fish_opt --short=s --long=disk_size --required-val)
    argparse --min-args=1 $options -- $argv
    if test -n "$argv"
        set vm_name $argv
        set disk_path (get-vm-disk-path $vm_name)
        if test -z "$_flag_disk_size"
            set disk_size (get-vm-disk-size $disk_path)
        else
            set disk_size $_flag_disk_size
        end
        if test -z "$_flag_confirm"
            read -P "Recreate $disk_path with size=$disk_size? " -n1 response
        else
            set response "Y"
        end
        if test "$response" = "Y" -o "$response" = "y"
            virsh destroy $vm_name
            echo "Sleeping for 5 sec..."
            sleep 5
            sudo rm $disk_path
            qemu-img create -f raw $disk_path $disk_size
            if test -z "$_flag_confirm"
                read -P "Would you like to start VM:$vm_name? " -n1 response
            else
                set response "Y"
            end
            if test "$response" = "Y" -o "$response" = "y"
                virsh start $vm_name
            end
        else
            echo "Aborting..."
        end
    else
        echo "vm_name required"
    end
end
