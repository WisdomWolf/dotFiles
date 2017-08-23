# Defined in /tmp/fish.GhuJrP/__get-gitlab-projects.fish @ line 2
function __get-gitlab-projects
	curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" "https://gitlab.com/api/v4/users/wisdomwolf/projects" -s
end
