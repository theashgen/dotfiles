#!/bin/bash

# Dotfiles Installer
# Usage: ./install.sh [--backup] [--force]

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[✗]${NC} $1"; exit 1; }

# Parse arguments
BACKUP=false
FORCE=false
for arg in "$@"; do
    case $arg in
        --backup) BACKUP=true ;;
        --force) FORCE=true ;;
        --help)
            echo "Usage: ./install.sh [OPTIONS]"
            echo "Options:"
            echo "  --backup   Backup existing configs before symlinking"
            echo "  --force    Overwrite existing symlinks"
            echo "  --help     Show this help"
            exit 0
            ;;
    esac
done

# Create backup directory if needed
backup_file() {
    local file="$1"
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        if [ "$BACKUP" = true ]; then
            mkdir -p "$BACKUP_DIR"
            cp -r "$file" "$BACKUP_DIR/"
            log "Backed up: $file"
        elif [ "$FORCE" = false ]; then
            warn "Skipping $file (exists, use --backup or --force)"
            return 1
        fi
    fi
    return 0
}

# Symlink with backup support
link_file() {
    local src="$1"
    local dst="$2"
    
    mkdir -p "$(dirname "$dst")"
    
    if [ -L "$dst" ]; then
        rm "$dst"
    elif [ -e "$dst" ]; then
        if ! backup_file "$dst"; then
            return
        fi
        rm -rf "$dst"
    fi
    
    ln -sf "$src" "$dst"
    log "Linked: $dst -> $src"
}

echo ""
echo "=== Dotfiles Installer ==="
echo ""

# Shell configs
echo "Setting up shell configuration..."
link_file "$DOTFILES_DIR/shell/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/shell/.zprofile" "$HOME/.zprofile"

# Config files (individual files only, so auto-generated app files stay local)
echo ""
echo "Setting up application configs..."
link_file "$DOTFILES_DIR/config/opencode/opencode.jsonc" "$HOME/.config/opencode/opencode.jsonc"
link_file "$DOTFILES_DIR/config/herdr/config.toml" "$HOME/.config/herdr/config.toml"
link_file "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"

echo ""
echo "=== Installation Complete ==="
echo ""
echo "Changes will take effect in new shell sessions."
echo "Run 'source ~/.zshrc' to apply immediately."
echo ""
if [ "$BACKUP" = true ]; then
    echo "Backups saved to: $BACKUP_DIR"
fi
