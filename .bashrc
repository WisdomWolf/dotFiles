#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


export MYPS='$(echo -n "${PWD/#$HOME/~}" | awk -F "/" '"'"'{
if (length($0) > 14) { if (NF>4) print $1 "/" $2 "/.../" $(NF-1) "/" $NF;
else if (NF>3) print $1 "/" $2 "/.../" $NF;
else print $1 "/.../" $NF; }
else print $0;}'"'"')'
#PS1='\e[32m\!\e[m | \e[33m\u@\h\e[m | \e[31m$(eval "echo ${MYPS}")\e[m \n$ '

if [ -n "$SSH_CLIENT" ]; then
	prompt_user_host_color='1;34'
else
	prompt_user_host_color='1;31'
fi

if [ -n "$STY" ]; then
	#Append (+) to username display when running in a screen session
	PS1='\e[32m\!\e[m | \e['$prompt_user_host_color'm\u@\h (+)\e[m | \e[31m$(eval "echo ${MYPS}")\e[m \n$ '
else
	PS1='\e[32m\!\e[m | \e['$prompt_user_host_color'm\u@\h\e[m | \e[31m$(eval "echo ${MYPS}")\e[m \n$ '
fi

# Auto-screen invocation. see: http://taint.org/wk/RemoteLoginAutoScreen
# if we're coming from a remote SSH connection, in an interactive session
# then automatically put us into a screen(1) session.   Only try once
# -- if $STARTED_SCREEN is set, don't try it again, to avoid looping
# if screen fails for some reason.
if [ "$PS1" != "" -a "${STARTED_SCREEN:-x}" = x -a "${SSH_TTY:-x}" != x ] 
then
  STARTED_SCREEN=1 ; export STARTED_SCREEN
  [ -z "$STY" ] && read && screen -Rd "work" || echo "Screen failed! continuing with normal bash startup"
fi
# [end of auto-screen snippet]

#------------------------------------------
#------WELCOME MESSAGE---------------------
# customize this first message with a message of your choice.
# this will display the username, date, time, a calendar, the amount of users, and the up time.

# Gotta love ASCII art with figlet
function figlet_welcome() {
	figlet "Welcome, " $USER;
	echo -e ""
	echo -ne "Today is "; date
	echo -e ""; cal ;
	echo "";
}

clear
if [ -e "${HOME}/.local/.bashrc_local" ]; then
    source "${HOME}/.local/.bashrc_local"
fi

# Gotta love ASCII art with figlet
type "figlet" > /dev/null 2>&1 && figlet_welcome
type "uptime" > /dev/null 2>&1 && uptime

### FUNCTIONS

# Easy extract
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

# Makes directory then moves into it
function mkcdr {
    mkdir -p -v $1
    cd $1
}

# Get IP (call with myip)
function myip {
  myip=`elinks -dump http://checkip.dyndns.org:8245/`
  echo "${myip}"
}

# Custom Exit Routine to ensure sync and trap screen
function exiter {
	if [ -n "$STY" ]; then
		echo -e "\nDon't exit from screen.  Detach with ctrl+a then d"
		echo -e "Alternatively, you can force disconnection with: <return>~.\n"
	else
		if [ $OSTYPE == "cygwin" ]; then
			syncuni
			$"exit"
		else
			$"exit"
		fi
	fi
}

# Sync profiles and aliases
function syncuni {
	unison -auto -batch
	error_code=$?
	if [ "$?" -ne "0" ]; then
		echo "Sync failed, run Unison manually to correct."
		read -p ""
	fi
}

div ()  # Arguments: dividend and divisor
{
        if [ $2 -eq 0 ]; then echo division by 0; exit; fi
        local p=12                            # precision
        local c=${c:-0}                       # precision counter
        local d=.                             # decimal separator
        local r=$(($1/$2)); echo -n $r        # result of division
        local m=$(($r*$2))
        [ $c -eq 0 ] && [ $m -ne $1 ] && echo -n $d
        [ $1 -eq $m ] || [ $c -eq $p ] && return
        local e=$(($1-$m))
        let c=c+1
        div $(($e*10)) $2
}

# Add aliases to file
function addalias() {
	if [ -z "$3" ] ; then
		echo "alias" $1="'"$2"'" >> ~/.bash_aliases
	elif [ $1 == "local" ] ; then
		echo "alias" $2="'"$3"'" >> ~/.local/.bash_aliases_local
	else
		echo "Malformed Command. Try Again."
	fi
}

# default ping to count of 4
function pinger() {
	if [ -z "$2" ] ; then
		ping "$1" count 4
	elif [ $2 != "x" ] ; then
		ping "$1" count "$2"
	else
		ping "$1"
	fi
}

# Create GitHub Repo
function create_github_repo() {
	local token='af31fabebc4fd696f7bf34aa2d56b876d53b9e62'
	local username='WisdomWolf'
	if [ -z "$1" ] ; then
		echo "Usage: create_github_repo reponame"
	else
		local repo_name=$1
		curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}'
	fi
}

# Create Butbucket Repo
function create_bitbucket_repo() {
	local token="$GITHUB_TOKEN"
	local username='WisdomWolf'
	if [ -z "$1" ] ; then
		echo "Usage: create_bitbucket_repo reponame"
	else
		local repo_name=$1
		curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}'
	fi
}

# startbitbucket - creates remote bitbucket repo and adds it as git remote to cwd
function startbitbucket {
	if [ -z "$BitBucketUser" ] ; then
		echo 'Username?'
		read username
	else
		local username="$BitBucketUser"
	fi
	if [ -z "$BitBucketPass" ] ; then
		echo 'Password?'
		read -s password  # -s flag hides password text
	else
		local password="$BitBucketPass"
	fi
    echo 'Repo name?'
    read reponame

    curl --user $username:$password https://api.bitbucket.org/1.0/repositories/ --data name=$reponame --data is_private='true'
    git remote add origin git@bitbucket.org:$username/$reponame.git
    git push -u origin --all
    git push -u origin --tags
}

# Slackbot Messages
function slackbot() {
	local channel=$1
	local message=$2
	local url='https://compass-dataservices.slack.com/services/hooks/slackbot'
	local token='f1Jl7KiWgQPs1QClcvYmTGoj'
	curl --data "$message" $"$url?token=$token&channel=%23$channel"
}

# Slackbot Messages direct to id10T-chat
function idiot_chat() {
	local channel='id10t-chat'
	local message=$1
	local url='https://compass-dataservices.slack.com/services/hooks/slackbot'
	local token='f1Jl7KiWgQPs1QClcvYmTGoj'
	curl --data "$message" $"$url?token=$token&channel=%23$channel"
}

# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

# don't put duplicate lines in the history. See bash(1) for more options
export HISTFILESIZE=300000    # save 300000 commands
export HISTCONTROL=ignoredups    # no duplicate lines in the history.
export HISTSIZE=100000

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### ALIASES
if [ -z "$SHELL_TYPE"]; then
	alias exit="exiter"
fi
[ -r ~/.bash_aliases ] && source ~/.bash_aliases


