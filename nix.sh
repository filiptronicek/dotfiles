#!/usr/bin/env bash
# shamelessly stolen from https://github.com/axonasif/dotsh/blob/main/src/install/packages.sh

nix_packages=(
    nixpkgs.zsh
    nixpkgs.git
    nixpkgs.coreutils
    nixpkgs.gnupg
    nixpkgs-unstable.neovim

    nixpkgs-unstable.nodejs
    nixpkgs-unstable.yarn
    nixpkgs-unstable.pnpm
    nixpkgs-unstable.bun
    nixpkgs-unstable.rust
    nixpkgs-unstable.go
    nixpkgs.python314
    nixpkgs.pipx
    nixpkgs.rustup
    nixpkgs.cmake

    nixpkgs.gh
    nixpkgs.wget
    nixpkgs.yt-dlp
    nixpkgs.ffmpeg
    nixpkgs.rclone
    nixpkgs.jq
    nixpkgs.yq-go
    nixpkgs.tree
    nixpkgs.unixtools.watch
    nixpkgs.dust
    nixpkgs.fastfetch

    nixpkgs.awscli2
    nixpkgs.google-cloud-sdk
    nixpkgs.cloudflared
    nixpkgs.knot-dns
)

function log::info() {
    echo "[INFO] $1"
}

function install_nix_packages() {
    # Ensure we have the current user
    USER="$(id -u -n)" && export USER

    # See if nix is installed (check `which nix` to see if it's installed)
    if [ ! -f "$(which nix)" ]; then
        sudo mkdir -p /nix
        sudo chown -R "$USER:$USER" /nix

        # Create the nixbld group
        groupadd -r nixbld

        # Create the build users (typically 1-32)
        for n in $(seq 1 10); do
        useradd -c "Nix build user $n" -d /var/empty -g nixbld -G nixbld -M -N -r -s "$(which nologin)" "nixbld$n"
        done
        
        log::info "Installing nix"
        curl -sL https://nixos.org/nix/install | bash -s -- --no-daemon
    fi

    # Source nix environment
    if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
        source "$HOME/.nix-profile/etc/profile.d/nix.sh"
    elif [ -f "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]; then
        source "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
    else
        log::info "Error: Could not find nix profile script"
        exit 1
    fi

    # Add unstable channel if needed
    if [[ "${nix_packages[*]}" == *nixpkgs-unstable.* ]]; then
        log::info "Adding nixpkgs-unstable channel"
        nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
        nix-channel --update
    fi

    # Install all packages
    if [ -n "${nix_packages[*]}" ]; then
        log::info "Installing packages: ${nix_packages[*]}"
        command nix-env -iAP "${nix_packages[@]}" 2>&1 \
            | grep --line-buffered -vE '^(copying|building|generating|  /nix/store|these|this path will be fetched)'
    fi
}

# Run the installation
log::info "Starting Nix package installation"
install_nix_packages
