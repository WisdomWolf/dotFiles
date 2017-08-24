# Defined in /tmp/fish.va1SNY/list-gitlab.fish @ line 2
function list-gitlab
	__get-gitlab-projects | jq -r '.[] | "\(.id)\t\(.name)\t\t\t\(.web_url)"'
end
