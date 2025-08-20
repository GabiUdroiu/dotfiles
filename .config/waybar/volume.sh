#!/bin/bash

sink=$(pactl info | grep 'Default Sink' | awk '{print $3}')
volume=$(pactl get-sink-volume "$sink" | grep -oP '\d+%' | head -1 | tr -d '%')
mute=$(pactl get-sink-mute "$sink" | awk '{print $2}')

if [ "$mute" = "yes" ] || [ "$volume" -eq 0 ]; then
    icon="󰖁"
    text=""
else
    icon=""
    text=""
fi

echo "{\"text\":\"$icon $text\",\"tooltip\":\"Volume: $volume%\"}"
