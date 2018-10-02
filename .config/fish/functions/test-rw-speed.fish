function test-rw-speed
	if test (count $argv) -lt 1
        set filename ./test_data
    else
        set filename $argv[1]
    end
    echo 'Testing Write Speed:'
    test-write-speed $filename
    echo 'Testing Read Speed:'
    test-read-speed $filename
    rm $filename
end
