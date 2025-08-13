#!/bin/bash

# Wallpaper directory
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Pick a random wallpaper file (jpg, png, jpeg)
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n1)

# Update symlink to current wallpaper
ln -sf "$WALLPAPER" "$HOME/.cache/current_wallpaper"

# Update hyprpaper config file
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"

echo "preload = $WALLPAPER" > "$HYPRPAPER_CONF"
echo "wallpaper = eDP-1,$WALLPAPER" >> "$HYPRPAPER_CONF"

# Reload hyprpaper to apply wallpaper (if not auto started)
pkill hyprpaper  # kill existing instance
hyprpaper &     # start fresh

