# shamelessly stolen from https://github.com/WVerlaek/dotfiles-gitpod-flex/blob/main/claude/.run

if command -v claude &> /dev/null; then
    echo "✨ Claude Code is already installed"
    return 0
fi

echo "🚀 Installing Claude Code..."
npm install -g @anthropic-ai/claude-code
claude config set -g theme dark

DEST="$HOME/.claude.json"
if ! sudo test -f "$DEST"; then
    echo "📋 Copying Claude config from root..."
    sudo cp /root/.claude.json "$DEST" || {
        echo "ℹ️  No Claude config found in root, skipping copy"
        return 0
    }
fi

sudo chown "$(id -u):$(id -g)" "$DEST"

echo "⚙️  Setting up Claude settings..."
mkdir -p ~/.claude
if [ ! -f ~/.claude/settings.json ]; then
    cat > ~/.claude/settings.json << 'EOF'
{
  "permissions": {
    "allow": [
      "Read(**)",
      "Edit(**)",
      "Bash(ls:*)",
      "Bash(grep:*)",
      "Bash(rg:*)",
      "Bash(find:*)",
      "Bash(go:*)",
      "Bash(git status:*)",
      "Bash(git diff:*)",
      "Bash(git add:*)",
      "Bash(git commit:*)",
      "Bash(git pull:*)",
      "Bash(git log:*)",
      "WebFetch(domain:www.gitpod.io)"
    ],
    "deny": []
  }
}
EOF
    echo "✅ Created ~/.claude/settings.json"
else
    echo "ℹ️  ~/.claude/settings.json already exists, skipping creation"
fi