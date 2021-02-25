function _create_github_repo
    set -l options (fish_opt --short=p --long=project --required-val)
    argparse $options -- $argv
    set -l project_name $_flag_project
    emit bg_notify_event "creating github repo"
    if test -z "$GITHUB_TOKEN"
        emit error_event "GITHUB_TOKEN must be set first"
        return 1
    end
    set -l new_project (curl -s \
        -u WisdomWolf:$GITHUB_TOKEN \
        -X POST \
        -H "Accept: application/vnd.github.v3+json" \
        https://api.github.com/user/repos \
        -d '{"name":"$project_name"}')
    set ssh_url (echo $new_project | jq -r '.ssh_url')
    emit bg_notify_event (echo $new_project | jq -r '"\(.id)\t\(.name)\t\(.html_url)"')
end
