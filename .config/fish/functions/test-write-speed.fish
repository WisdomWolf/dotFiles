function test-write-speed
	if test (count $argv) -lt 1
set out_file ./test_data
else
set out_file $argv[1]
end
dd bs=16k count=102400 oflag=direct if=/dev/zero of=$out_file status=progress
end
