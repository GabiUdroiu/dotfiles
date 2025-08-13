#!/bin/bash

# Get max and current brightness
max_brightness=$(cat /sys/class/backlight/intel_backlight/max_brightness)
current_brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
current_percent=$(( current_brightness * 100 / max_brightness ))

# Check for input
if [ -z "$1" ]; then
  echo "Usage: $0 <percent | +N | -N>"
  exit 1
fi

input="$1"

# Determine new percentage
if [[ "$input" =~ ^[+-][0-9]+$ ]]; then
  percent=$(( current_percent + input ))
else
  if ! [[ "$input" =~ ^[0-9]+$ ]] || [ "$input" -lt 0 ] || [ "$input" -gt 100 ]; then
    echo "Error: Must be a number (0–100) or relative (+/-N)"
    exit 1
  fi
  percent=$input
fi

# Clamp to 0–100 range
if [ "$percent" -lt 0 ]; then
  percent=0
elif [ "$percent" -gt 100 ]; then
  percent=100
fi

# Set brightness
new_value=$(( max_brightness * percent / 100 ))
echo $new_value | sudo tee /sys/class/backlight/intel_backlight/brightness > /dev/null

# Show notification
notify-send -t 1000 "Brightness: $percent%"

