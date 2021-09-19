# Defined in /tmp/fish.w2kzi1/stash-update.fish @ line 2
function stash-update
    stash-clean
    stash-scan
    cd stash_theporndb_scraper
    python scrapeScenes.py -ro
    stash-generate-metadata
end
