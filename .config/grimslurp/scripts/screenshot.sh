#!/bin/bash

DIR=~/Pictures/Screenshots

FILE_NAME="screenshot-$(date '+%d-%m-%Y_%H-%M-%S').png"

grim -g "$(slurp)" "$DIR/$FILE_NAME"

swappy -f "$DIR/$FILE_NAME" -o "$DIR/$FILE_NAME"

wl-copy < "$DIR/$FILE_NAME"

notify-send "📸 Screenshot saved" "$FILE_NAME copied to clipboard"
