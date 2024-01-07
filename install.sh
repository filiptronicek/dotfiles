#!/bin/bash

alias gitpod="gp"
alias amp="git add . && git commit --amend --no-edit && git push -f" # amend, push
alias ampu="git add . && git commit --amend && git push -f" # amend, push, update commit message
alias sizeof="du -sh"

sudo apt install zsh git-core curl fonts-powerline  -y

# Atuin

bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
atuin login -u "$ATUIN_USERNAME" -p "$ATUIN_PASSWORD" --key "$ATUIN_KEY"
atuin sync
touch ~/.config/atuin/config.toml
echo "sync_frequency = \"5m\"" >> ~/.config/atuin/config.toml

npm i -g vsce ovsx

if [ -n "${GITPOD_WORKSPACE_URL}" ]; then
    ~/.dotfiles/scripts/tailscale.sh &
fi
