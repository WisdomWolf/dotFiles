#!/bin/bash

die() {
    printf '%s\n' "$1" >&2
    exit 1
}

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
    case $1 in
        -l|--selector)
            if [ "$2" ]; then
                SELECTOR=$2
                shift
            else
                die '"--selector" requires a non-empty option'
            fi
            ;;
        --selector=?*)
            SELECTOR=${1#*=}
            ;;
        --selector=)
            die '"--selector" requires a non-empty option'
            ;;
        -i|--identity-file)
            if [ "$2" ]; then
                SSH_IDENTITY_FILE=$2
                shift
            else
                die '"--identity-file" requires a non-empty option'
            fi
            ;;
        --identity-file=?*)
            SSH_IDENTITY_FILE=${1#*=}
            ;;
        --identity-file=)
            die '"--identity-file" requires a non-empty option'
            ;;
        -p|--port)
            if [ "$2" ]; then
                SSH_PORT=$2
                shift
            else
                die '"--port" requires a non-empty option'
            fi
            ;;
        --port=?*)
            SSH_PORT=${1#*=}
            ;;
        --port=)
            die '"--port" requires a non-empty option'
            ;;
        -u|--username)
            if [ "$2" ]; then
                SSH_USERNAME=$2
                shift
            else
                die '"--username" requires a non-empty option'
            fi
            ;;
        --username=?*)
            SSH_USERNAME=${1#*=}
            ;;
        --username=)
            die '"--username" requires a non-empty option'
            ;;
        -a|--address-type)
            if [ "$2" ]; then
                ADDRESS_TYPE=$2
                shift
            else
                die '"--address-type" requires a non-empty option'
            fi
            ;;
        --address-type=?*)
            ADDRESS_TYPE=${1#*=}
            ;;
        --address-type=)
            die '"--address-type" requires a non-empty option'
            ;;
        --synchronize)
            SYNCHRONIZE_PANES=1
            ;;
        --no-synchronize)
            SYNCHRONIZE_PANES=0
            ;;
        -h|--help)
            HELP_TEXT="$(cat <<-EOF
Allows users to SSH into Kubernetes nodes by opening a new tmux pane for each matching node

Options:
  -a, --address-type='ExternalIP': Node address type to query for (e.g. InternalIP/ExternalIP)
  -i, --identity-file='': Selects a file from which the identity (private key) for public key authentication is read
  -l, --selector='': Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2)
  -p, --port='': SSH port
  -u, --username='': SSH Username

Usage:
  kubectl cssh [flags] [options]
EOF
)"

            die "$HELP_TEXT"
            ;;
        -v|--version)
            echo "$KUBECTL_SSH_VERSION"
            exit
            ;;

        # handle unknown arguments as positional and save for later use
        *)
            POSITIONAL_ARGS+=("$1")
            ;;
    esac

    shift
done
