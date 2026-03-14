#!/bin/bash
DOTFILES="$HOME/Development/dotfiles"

if [ ! -d "$DOTFILES" ]; then
    echo "dotfiles dir not found at $DOTFILES"
    exit 1
fi

link() {
    local src="$DOTFILES/$1"
    local dest="$2"

    mkdir -p "$(dirname "$dest")"

    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
        return
    fi

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        mv "$dest" "$dest.bak"
        echo "backed up $dest -> $dest.bak"
    fi

    ln -sf "$src" "$dest"
    echo "linked $dest -> $src"
}

# If ~/.ssh exists but is not a directory, fix it
if [ -e "$HOME/.ssh" ] && [ ! -d "$HOME/.ssh" ]; then
    mv "$HOME/.ssh" "$HOME/.ssh_key.bak"
    echo "moved ~/.ssh (was a file) -> ~/.ssh_key.bak"
fi
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

link "ghosty"              "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
link "aerospace.toml"      "$HOME/.config/aerospace/aerospace.toml"
link ".zshrc"              "$HOME/.zshrc"
link ".gitconfig"          "$HOME/.gitconfig"
link ".gitignore_global"   "$HOME/.gitignore_global"
link "ssh_config"          "$HOME/.ssh/config"
link "sync.sh"             "$HOME/.local/bin/config-sync"

chmod +x "$DOTFILES/sync.sh"
chmod +x "$DOTFILES/toggle-ghostty-shader.sh"

aerospace reload-config
pkill -USR2 ghostty

echo "dotfiles synced"
