function get-updated-functions
for line in (yadm diff ~/.config/fish/functions | grep diff | cut -d' ' -f 3)
echo (string split '/' $line)[-1]
end
end
