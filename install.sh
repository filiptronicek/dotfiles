#!/bin/bash

# Source the nix installer
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/nix.sh"

if [ -n "${GITPOD_WORKSPACE_URL}" ]; then
    # authenticate gh cli
    GH_TOKEN=$(printf '%s\n' "host=github.com" | gp credential-helper get | awk -F'password=' '{print $2}' | tr -d '[:space:]')
    gh auth login --with-token <<< "$GH_TOKEN"
fi

npm i -g vsce ovsx

sudo chsh "$(id -un)" --shell "/usr/bin/zsh"
