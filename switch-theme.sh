#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEMES_DIR="$DOTFILES_DIR/themes"

THEME="${1:-}"

if [ -z "$THEME" ]; then
    AVAILABLE_THEMES=$(find "$THEMES_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)
    if command -v rofi >/dev/null 2>&1; then
        THEME=$(echo "$AVAILABLE_THEMES" | rofi -dmenu -p "Theme" || true)
    else
        read -rp "Theme: " THEME
    fi
fi

if [ -z "$THEME" ]; then
    exit 0
fi

CHOSEN_DIR="$THEMES_DIR/$THEME"

if [ ! -d "$CHOSEN_DIR" ]; then
    exit 1
fi

if [ -d "$CHOSEN_DIR/polybar" ]; then
    mkdir -p ~/.config/polybar
    cp -r "$CHOSEN_DIR/polybar/"* ~/.config/polybar/
fi

if [ -f "$CHOSEN_DIR/alacritty/alacritty.toml" ]; then
    mkdir -p ~/.config/alacritty
    cp "$CHOSEN_DIR/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml
fi

if [ -f "$CHOSEN_DIR/rofi/config.rasi" ]; then
    mkdir -p ~/.config/rofi
    cp "$CHOSEN_DIR/rofi/config.rasi" ~/.config/rofi/config.rasi
fi

if [ -f "$CHOSEN_DIR/dunst/dunstrc" ]; then
    mkdir -p ~/.config/dunst
    cp "$CHOSEN_DIR/dunst/dunstrc" ~/.config/dunst/dunstrc
    killall dunst 2>/dev/null || true
    dunst & disown
fi

if [ -f "$CHOSEN_DIR/gtk-3.0/gtk.css" ]; then
    mkdir -p ~/.config/gtk-3.0
    cp "$CHOSEN_DIR/gtk-3.0/gtk.css" ~/.config/gtk-3.0/gtk.css
fi

if [ -f "$CHOSEN_DIR/wallpaper.jpg" ]; then
    if command -v feh >/dev/null 2>&1; then
        feh --bg-fill "$CHOSEN_DIR/wallpaper.jpg"
    fi
fi

if command -v i3-msg >/dev/null 2>&1; then
    i3-msg reload >/dev/null 2>&1 || true
fi
