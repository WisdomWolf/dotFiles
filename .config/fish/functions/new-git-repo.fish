# Defined in /home/wisdomwolf/.config/fish/functions/new-git-repo.fish @ line 1
function new-git-repo
    set -l options (fish_opt --short=h --long=help)
    set -la options (fish_opt --short=t --long=host --required-val)
    set -la options (fish_opt --short=p --long=project --required-val)
    set -la options (fish_opt --short=d --long=debug --optional-val)
    argparse $options -- $argv
    if test -z "$_flag_debug"
        echo 'DEBUG activated!'
        set -l
    end
    if test -z "$_flag_project"
        set project_name (string split '/' (pwd))[-1]
    else
        set project_name $_flag_project
    end
    echo "DEBUG: project_name = $project_name"
    if test -n "$_flag_host"
        switch $_flag_host
            case "github"
                echo "calling create_github_repo"
                set response (_create_github_repo --project $project_name)
                echo "response: $response"
            case "gitlab"
                echo "calling create_gitlab repo"
                set response (_create_gitlab_repo --project $project_name)
                echo "response: $response"
            case '*'
                echo "No config for $_flag_host exists"
                return 1
        end
    else
        echo "You must provide a host to create repo on"
        return 1
    end
    if test "$response" = "1"
        echo "something went wrong creating the repo...try again"
        return 1
    else
        set ssh_url $response
    end
    read -p 'echo "Would you like to add this project as remote git repo? "' -n 1 -l add_git_repo
    if test "$add_git_repo" = "y" -o "$add_git_repo" = "Y"
        git remote add origin $ssh_url
        echo "remote repo set to $ssh_url"
    else
        echo "Not setting remote repo"
    end
end
