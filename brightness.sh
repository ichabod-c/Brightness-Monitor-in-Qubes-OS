#!/bin/bash

# Get the current brightness level
current_brightness=$(cat /sys/class/backlight/intel_backlight/brightness)

# Convert the current brightness to a scale of 0 to 1 for xrandr
current_brightness_scaled=$(echo "scale=2; $current_brightness / 100" | bc)

# Increase or decrease the brightness
if [ "$1" == "up" ]; then
    new_brightness_scaled=$(echo "$current_brightness_scaled + 0.1" | bc)
    # Check if the new brightness is greater than 1 (maximum brightness)
    if (( $(echo "$new_brightness_scaled > 1" | bc -l) )); then
        new_brightness_scaled=1
    fi
elif [ "$1" == "down" ]; then
    new_brightness_scaled=$(echo "$current_brightness_scaled - 0.1" | bc)
    # Check if the new brightness is less than 0 (minimum brightness)
    if (( $(echo "$new_brightness_scaled < 0" | bc -l) )); then
        new_brightness_scaled=0.1
    fi
else
    exit 1
fi

# Convert the new brightness back to the scale of the Intel file
new_brightness=$(echo "$new_brightness_scaled * 100" | bc | awk '{printf("%d\n",$1 + 0.5)}')

# Set the new brightness level
xrandr --output DP-1 --brightness $new_brightness_scaled

# Update the Intel file
sudo bash -c "echo $new_brightness > /sys/class/backlight/intel_backlight/brightness"
