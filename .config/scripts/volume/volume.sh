#!/bin/bash

if [ "$1" = "up" ]; then
  wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
elif [ "$1" = "down" ]; then
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
else
  echo "Usage: $0 up|down"
  exit 1
fi

# Wait a tiny bit to make sure volume changed
sleep 0.1

# Get current volume percentage (rounded)
vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{print $2}')
vol_percent=$(awk "BEGIN {printf \"%d\", $vol * 100}")

notify-send -r 6666  -t 1000 "Volume: $vol_percent%"
