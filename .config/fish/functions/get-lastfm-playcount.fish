function get-lastfm-playcount
set track_name $argv[1]
set artist_name $argv[2]
set username $argv[3]
curl -sL "http://ws.audioscrobbler.com/2.0/?method=track.getInfo&api_key=$LASTFM_API_KEY&artist=$artist_name&track=$track_name&username=$username&format=json" | jq -r '.track.userplaycount'
end
