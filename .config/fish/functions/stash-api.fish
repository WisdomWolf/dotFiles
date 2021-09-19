function stash-api
curl "$STASH_URL/graphql" \
    -H 'Accept-Encoding: gzip, deflate, br' \
    -H 'Content-Type: application/json' \
    -H 'Accept: application/json' \
    -H 'Connection: keep-alive' \
    -H 'DNT: 1' \
    -H "Origin: $STASH_URL" \
    -H "ApiKey: $STASH_API_KEY" \
    --compressed \
    $argv
end
