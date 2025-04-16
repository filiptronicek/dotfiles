# Aliases

alias ls="exa"
alias python="/opt/homebrew/bin/python3.12"
alias pip="/opt/homebrew/bin/pip3.12"

alias ytmp3="yt-dlp -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o '%(title)s.%(ext)s'"
alias ytvideo="yt-dlp -f bestvideo+bestaudio --merge-output-format mov -o '%(title)s.%(ext)s'"

export PATH="/Users/filip/.cargo/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# bun completions
[ -s "/Users/filip/.bun/_bun" ] && source "/Users/filip/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh" }}\x9c'

eval "$(zoxide init zsh --cmd cd)"

# Source nix
source "$HOME/.nix-profile/etc/profile.d/nix.sh"

export EDITOR="cursor --wait"
