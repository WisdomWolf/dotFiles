# Defined in - @ line 2
function pinger
	if test (count $argv) -gt 1
        set timeout $argv[2]
    else
        set timeout 300 # Five minutes
    end
    set address $argv[1]
    printf "Running pinger on %s with timeout of %d\n" $address $timeout
    ping -w $timeout -c 1 -f -i 1 $address
    if test $status -gt 0
        read -P "Ping attempt timed out.  Retry? " -n 1 retry_response
        if test $retry_response = "y"
            return (pinger $argv)
        else
            echo "Cancelling Pinger..."
            return 1
        end
    else
        echo "Ping success!"
        return 0
    end
end
