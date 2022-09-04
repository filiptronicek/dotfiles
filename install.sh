#!/bin/bash

sudo apt install zsh git-core curl fonts-powerline  -y

npm i -g vsce ovsx

if [ -n "${GITPOD_WORKSPACE_URL}" ]; then
    ~/.dotfiles/scripts/tailscale.sh &
fi
