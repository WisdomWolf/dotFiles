function version
echo "$argv" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'
end