#!/bin/bash

# Source the nix installer
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/scripts/nix.sh"
source "$SCRIPT_DIR/scripts/claude.sh"

if [ -n "${GITPOD_WORKSPACE_URL}" ]; then
    # authenticate gh cli for Gitpod Classic
    GH_TOKEN=$(printf '%s\n' "host=github.com" | gp credential-helper get | awk -F'password=' '{print $2}' | tr -d '[:space:]')
    gh auth login --with-token <<< "$GH_TOKEN"
fi

if [ -n "${GITPOD_ENVIRONMENT_ID}" ]; then
    # authenticate gh cli for Gitpod
    GH_TOKEN=$(awk -F= '/^password=/ {print $2}' /usr/local/gitpod/shared/git-secrets/*)
fi

npm i -g vsce ovsx

# Install oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# Change default shell to zsh
sudo chsh "$(id -un)" --shell "/usr/bin/zsh"
