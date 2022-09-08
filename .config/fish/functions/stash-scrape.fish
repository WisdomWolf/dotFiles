function stash-scrape
    if test -z "$argv"
        set args "-no"
    else
        set args "$argv"
    end
    ~/.pyenv/versions/stash_theporndb_scraper/bin/python ~/stash_theporndb_scraper/scrapeScenes.py -no
end
