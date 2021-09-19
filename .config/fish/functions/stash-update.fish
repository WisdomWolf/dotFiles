# Defined in /tmp/fish.aVcRh0/stash-update.fish @ line 2
function stash-update
    stash-scan
    cd stash_theporndb_scraper
    python scrapeScenes.py -ro
    stash-generate-metadata
end
