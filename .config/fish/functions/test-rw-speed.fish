function test-rw-speed
	if test (count $argv) -lt 1
set filename ./test_data
else
set filename $argv[1]
end
test-write-speed $filename
test-read-speed $filename
rm $filename
end
