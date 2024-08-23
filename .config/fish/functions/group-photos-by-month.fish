function group-photos-by-month
    if test -z "$argv"
        set search_str *.JPG
    else
        set search_str $argv
    end
    for file in (ls $search_str)
        set date_str (echo "$file" | cut -d_ -f1)
        set date_dir (date --date="$date_str" "+%Y-%m")
        mkdir -pv "$date_dir"
        mv -v -- "$file" "$date_dir/"
    end
end
