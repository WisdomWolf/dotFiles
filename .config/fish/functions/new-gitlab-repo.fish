function new-gitlab-repo
	curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" https://gitlab.com/api/v4/projects -d name=$argv[1]
end
