function stash-clean
stash-api --data-binary '{"query":"mutation { metadataClean() }"}'
end
