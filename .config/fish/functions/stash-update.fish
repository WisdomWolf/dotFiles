function stash-update
stash-scan
python scrapeScenes.py -ro
stash-generate-metadata
end
