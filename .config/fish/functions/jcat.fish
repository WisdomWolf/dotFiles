function jcat
set filename $argv[1]
cat $filename | jq '.' -C | less
end
