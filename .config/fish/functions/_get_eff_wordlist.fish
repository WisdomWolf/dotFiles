function _get_eff_wordlist
    set cache_file ~/.config/fish/eff_wordlist.txt
    set cache_age_days 30
    set wordlist_url "https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt"

    # Check if cache exists and is fresh
    if test -f $cache_file
        set cache_age (math (date +%s) - (_file_age_seconds $cache_file))
        set max_age (math $cache_age_days \* 86400)
        if test $cache_age -lt $max_age
            echo $cache_file
            return 0
        end
    end

    # Fetch fresh copy — awk filters to tab-delimited lines and takes field 2
    # in one step, avoiding grep -P (GNU-only; breaks on BSD/macOS grep)
    if curl -sf --max-time 10 $wordlist_url | awk -F'\t' 'NF>=2{print $2}' > $cache_file.tmp 2>/dev/null
        and test (wc -l < $cache_file.tmp) -gt 1000
        mv $cache_file.tmp $cache_file
        echo $cache_file
        return 0
    end

    # Fetch failed — use stale cache if available
    if test -f $cache_file
        echo "Warning: using stale wordlist cache" >&2
        echo $cache_file
        return 0
    end

    # No cache and fetch failed — signal failure with empty string
    echo ""
    return 1
end