# Defined in /tmp/fish.A2X5aF/new-gitlab-repo.fish @ line 3
function new-gitlab-repo
	set -l new_project (curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" -s https://gitlab.com/api/v4/projects -d name=$argv[1])
    set -l ssh_url (echo $new_project | jq -r '.ssh_url_to_repo')
    echo $new_project | jq -r '"\(.id)\t\(.name)\t\(.web_url)"'
    read -P "Would you like to add this project as remote git repo? " -n 1 -l add_git_repo
    if test "$add_git_repo" = "y" -o "$add_git_repo" = "Y"
        git remote add origin $ssh_url
        echo "remote repo set"
    else
        echo "Not setting remote repo"
    end
end
