# Defined in /tmp/fish.OParEm/stash-clean.fish @ line 2
function stash-clean
    stash-api --data-binary '{"query":"mutation { metadataClean( input: { dryRun: false} ) }"}'
end
