function group-photos-by-month
for file in (ls *.JPG)
set date_str (echo "$file" | cut -d_ -f1)
set date_dir (date --date="$date_str" "+%Y-%m")
mkdir -pv "$date_dir"
mv -v -- "$file" "$date_dir/"
end
end
