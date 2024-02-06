#!/bin/bash

alias gitpod="gp"
alias amp="git add . && git commit --amend --no-edit && git push -f" # amend, push
alias ampu="git add . && git commit --amend && git push -f" # amend, push, update commit message
alias sizeof="du -sh"

sudo apt install zsh git-core curl fonts-powerline  -y

npm i -g vsce ovsx

if [ -n "${GITPOD_WORKSPACE_URL}" ]; then
    ~/.dotfiles/scripts/tailscale.sh &
fi
