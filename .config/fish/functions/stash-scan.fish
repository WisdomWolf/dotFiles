function stash-scan
stash-api --data-binary '{"query":"mutation { metadataScan ( input : { useFileMetadata: true  stripFileExtension: true })}"}'
end
