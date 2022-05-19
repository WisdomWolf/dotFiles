# Defined in /tmp/fish.lQzcJ9/stash-update.fish @ line 2
function stash-update
    stash-stop-all
    stash-clean
    stash-scan
    ~/.pyenv/versions/stash_theporndb_scraper/bin/python ~/stash_theporndb_scraper/scrapeScenes.py -no
    stash-generate-metadata
end
