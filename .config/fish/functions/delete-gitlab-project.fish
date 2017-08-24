function delete-gitlab-project
	set -l project_name (curl -s --header "PRIVATE-TOKEN: $GITLAB_TOKEN" "https://gitlab.com/api/v4/projects/$argv[1]" | jq -r ".name")
read -l -P "Are you sure you want to delete $project_name? " -n 1 delete_repo
if test "$delete_repo" = "y"
curl -X DELETE --header "PRIVATE-TOKEN: $GITLAB_TOKEN" "https://gitlab.com/api/v4/projects/$argv[1]"
else
echo "Not deleting $project_name"
end
end
