# Defined in /tmp/fish.vHkaH5/new-git-repo.fish @ line 2
function new-git-repo
    set -l options (fish_opt --short=h --long=help)
    set -la options (fish_opt --short=r --long=provider --required-val)
    set -la options (fish_opt --short=p --long=project --required-val)
    set -la options (fish_opt --short=d --long=debug)
    argparse $options -- $argv
    if test -n "$_flag_debug"
        emit bg_notify_event 'DEBUG activated!'
        set -l
    end
    if test -z "$_flag_project"
        set project_name (string split '/' (pwd))[-1]
    else
        set project_name $_flag_project
    end
    echo "DEBUG: project_name = $project_name"
    if test -n "$_flag_provider"
        switch $_flag_provider
            case "github"
                emit bg_notify_event "calling create_github_repo"
                set response (_create_github_repo --project $project_name)
                emit bg_notify_event "response: $response"
            case "gitlab"
                emit bg_notify_event "calling create_gitlab repo"
                set response (_create_gitlab_repo --project $project_name)
                emit bg_notify_event "response: $response"
            case '*'
                echo "No config for $_flag_host exists"
                return 1
        end
    else
        echo "You must provide a provider to create repo on"
        return 1
    end
    if test "$response" = "1"
        echo "something went wrong creating the repo...try again"
        return 1
    else
        set ssh_url $response
    end
    if test -n "$ssh_url"
        read -p 'echo "Would you like to add this project as remote git repo? "' -n 1 -l add_git_repo
        if test "$add_git_repo" = "y" -o "$add_git_repo" = "Y"
            git remote add origin $ssh_url
            emit bg_notify_event "remote repo set to $ssh_url"
        else
            echo "Not setting remote repo"
        end
    else
        echo 'SSH URL is empty!'
        return 1
    end
end
