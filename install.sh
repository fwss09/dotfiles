#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p ~/.config/i3
cp -f "$DOTFILES_DIR/common/i3/config" ~/.config/i3/config

mkdir -p ~/wallpapers
cp -r "$DOTFILES_DIR/wallpapers/"* ~/wallpapers/

"$DOTFILES_DIR/switch-theme.sh" deep-dark
