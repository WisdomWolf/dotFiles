function make-gitlab-private
	set -l proj_number $argv[1]
curl -s -X PUT \
--header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
--header "Content-Type: Application/json" \
-d '{"repository_access_level": "private", "builds_access_level": "private", "merge_requests_access_level": "private"}' \
"https://gitlab.com/api/v4/projects/$proj_number"
end
