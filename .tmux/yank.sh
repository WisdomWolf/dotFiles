#!/bin/bash
buf=$(cat)
encoded=$(echo -n "$buf" | base64 | tr -d '\n')
printf "\033]52;c;%s\a" "$encoded" > /dev/tty
