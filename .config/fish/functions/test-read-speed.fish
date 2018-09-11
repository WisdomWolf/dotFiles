function test-read-speed
	if test (count $argv) -lt 1
set in_file ./test_data
else
set in_file $argv[1]
end
dd bs=16k count=102400 iflag=direct if=$in_file of=/dev/zero status=progress
end
