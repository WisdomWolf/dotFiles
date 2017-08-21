function list-gitlab
	curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" "https://gitlab.com/api/v4/users/wisdomwolf/projects?simple=true" -s | jq -r '.[] | "\(.id)\t\(.name)\t\t\t\(.web_url)"'
end
