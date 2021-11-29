#!/usr/bin/env bash
OS=$(uname -s)
if [[ "$OS" = "Linux" ]]; then
    ID=$(cat /etc/os-release | grep ID_LIKE | cut -d\= -f 2)
    if [[ "$ID" = "arch" ]]; then
        sudo pacman -S --needed --noconfirm base-devel openssl zlib xz
    else if [[ "$ID" = "debian" ]]; then
        sudo apt update; sudo apt install -y make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    fi
else if [[ "$OS" = "Darwin" ]]; then
    brew install openssl readline sqlite3 xz zlib
fi

