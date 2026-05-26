function generate-passphrase
    set word_count (test -n "$argv[1]"; and echo $argv[1]; or echo 3)
    set separator (test -n "$argv[2]"; and echo $argv[2]; or echo ".")
    
    set wordlist (_get_eff_wordlist)
    
    if test -n "$wordlist"
        set words (shuf -n $word_count $wordlist)
    else if test -f /usr/share/dict/words
        echo "Warning: falling back to local dictionary" >&2
        set words (grep -E '^[a-z]{4,8}$' /usr/share/dict/words | shuf -n $word_count)
    else
        echo "Error: No wordlist available" >&2
        return 1
    end
    
    echo $words | tr ' ' $separator
end
