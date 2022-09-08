# Defined in /tmp/fish.lQzcJ9/stash-update.fish @ line 2
function stash-update
    stash-stop-all
    stash-clean
    stash-scan
    stash-scrape
    stash-generate-metadata
end
