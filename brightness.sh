#!/bin/bash

# Get the current brightness level
current_brightness=$(cat /sys/class/backlight/intel_backlight/brightness)

# Increase or decrease the brightness
if [ "$1" == "up" ]; then
    new_brightness=$(echo "$current_brightness + 0.1" | bc)
    # Check if the new brightness is greater than 1 (maximum brightness)
    if (( $(echo "$new_brightness > 1" | bc -l) )); then
        new_brightness=1
    fi
elif [ "$1" == "down" ]; then
    new_brightness=$(echo "$current_brightness - 0.1" | bc)
    # Check if the new brightness is less than 0 (minimum brightness)
    if (( $(echo "$new_brightness < 0" | bc -l) )); then
        new_brightness=0
    fi
else
    exit 1
fi

# Set the new brightness level
xrandr --output DP-1 --brightness $new_brightness

# Update the Intel file
sudo bash -c "echo $new_brightness > /sys/class/backlight/intel_backlight/brightness"
