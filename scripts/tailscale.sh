#!/bin/bash

curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list

sudo apt-get update
sudo apt-get install tailscale

if [ -n "${TS_STATE_TAILSCALE_EXAMPLE}" ]; then
    # restore the tailscale state from gitpod user's env vars
    sudo mkdir -p /var/lib/tailscale
    echo "${TS_STATE_TAILSCALE_EXAMPLE}" | sudo tee /var/lib/tailscale/tailscaled.state > /dev/null
fi
    sudo tailscaled &

if [ -n "${TS_STATE_TAILSCALE_EXAMPLE}" ]; then
    sudo -E tailscale up --authkey=$TAILSCALE_AUTHKEY &
else
    sudo -E tailscale up --hostname "gitpod-${GITPOD_GIT_USER_NAME// /-}-$(echo ${GITPOD_WORKSPACE_CONTEXT} | jq -r .repository.name)" --ssh  --authkey=$TAILSCALE_AUTHKEY &
    # store the tailscale state into gitpod user
    gp env TS_STATE_TAILSCALE_EXAMPLE="$(sudo cat /var/lib/tailscale/tailscaled.state)"
fi
