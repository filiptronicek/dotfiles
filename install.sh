#!/bin/bash

# Source the nix installer
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
# source "$SCRIPT_DIR/scripts/nix.sh"

if [ -n "${GITPOD_WORKSPACE_URL}" ]; then
    # authenticate gh cli for Gitpod Classic
    GH_TOKEN=$(printf '%s\n' "host=github.com" | gp credential-helper get | awk -F'password=' '{print $2}' | tr -d '[:space:]')
    gh auth login --with-token <<< "$GH_TOKEN"
fi

if [ -n "${GITPOD_ENVIRONMENT_ID}" ]; then
    # authenticate gh cli for Gitpod
    GH_TOKEN=$(awk -F= '/^password=/ {print $2}' /usr/local/gitpod/shared/git-secrets/*)
    gh auth login --with-token <<< "$GH_TOKEN"
fi

npm i -g vsce ovsx
curl -fsSL https://bun.sh/install | bash

# Install Ona skills into all workspaces
if [ -n "$(ls -A /workspaces 2>/dev/null)" ]; then
    for dir in /workspaces/*/; do
        # Copy public skills
        if [ -d "$SCRIPT_DIR/.ona/skills" ]; then
            echo -e "\033[32mInstalling public Ona skills in ${dir}\033[0m"
            mkdir -p "${dir}.ona/skills"
            cp -r "$SCRIPT_DIR/.ona/skills/"* "${dir}.ona/skills/." 2>/dev/null || echo "Could not copy public skills to ${dir}"
        fi

        # Clone private skills into gitpod-next workspaces
        workspace_name=$(basename "$dir")
        if [ "$workspace_name" = "gitpod-next" ]; then
            echo -e "\033[33mCloning private Ona skills into ${dir}\033[0m"
            mkdir -p "${dir}.ona/skills"
            if gh repo clone filiptronicek/ona-monorepo-skills /tmp/ona-monorepo-skills -- --depth 1 2>/dev/null; then
                cp -r /tmp/ona-monorepo-skills/skills/* "${dir}.ona/skills/." 2>/dev/null || echo "Could not copy private skills to ${dir}"
                rm -rf /tmp/ona-monorepo-skills
            else
                echo "Could not clone filiptronicek/ona-monorepo-skills (repo may not exist yet)"
            fi
        fi

        # Exclude .ona/skills from git tracking without modifying .gitignore
        if [ -d "${dir}.git" ]; then
            exclude_file="${dir}.git/info/exclude"
            mkdir -p "${dir}.git/info" 2>/dev/null
            if ! grep -qxF '.ona/skills/' "$exclude_file" 2>/dev/null; then
                echo '.ona/skills/' >> "$exclude_file"
            fi
        fi
    done
fi

# Install oh-my-zsh
KEEP_ZSHRC=yes sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# Change default shell to zsh
sudo chsh "$(id -un)" --shell "/usr/bin/zsh"
