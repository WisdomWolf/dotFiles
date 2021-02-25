function _create_gitlab_repo
    set -l options (fish_opt --short=p --long=project --required-val)
    argparse $options -- $argv
    set -l project_name $_flag_project
    emit bg_notify_event "creating gitlab repo"
    if test -z "$GITLAB_TOKEN"
        echo "GITLAB_TOKEN must be set first"
        return 1
    end
    set -l new_project (curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" -s https://gitlab.com/api/v4/projects -d name=$project_name)
    set ssh_url (echo $new_project | jq -r '.ssh_url_to_repo')
    emit bg_notify_event (echo $new_project | jq -r '"\(.id)\t\(.name)\t\(.web_url)"')
    echo $ssh_url
end
