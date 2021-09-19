# Defined in /tmp/fish.nCRNap/stash-generate-metadata.fish @ line 2
function stash-generate-metadata
    stash-api --data-binary '{"query":"mutation { metadataGenerate ( input : { sprites: true  previews: true  imagePreviews: true  markers: false  transcodes: false  phashes: true } ) }"}'
end
