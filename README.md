# External Monitor Brightness Control for Qubes OS

This Bash script provides a simple and efficient way to adjust the brightness of your external monitor in Qubes OS. It reads the current brightness level from `/sys/class/backlight/intel_backlight/brightness`, increases or decreases the brightness based on the argument passed ("up" or "down"), and then updates the brightness level using `xrandr` and `/sys/class/backlight/intel_backlight/brightness`. The script also ensures that the brightness level stays within the range of 0 to 1.

## Usage

To increase the brightness:

```bash
./brightness.sh up
```

To decrease the brightness:

```bash
./brightness.sh down
```

This script can be easily linked to a keyboard shortcut for quick brightness adjustments without the need to open system settings.

## Customization

This script is designed to be flexible and can be modified to suit your specific needs. Here are a few suggestions for customization:

- **Monitor Name**: The script currently assumes that your monitor is named "DP-1". If your monitor has a different name, you can replace "DP-1" with the actual name of your monitor in the `xrandr` command.

- **Brightness Adjustment Step**: The script currently increases or decreases the brightness by 0.1. If you want to make larger or smaller adjustments, you can change the value "0.1" in the script to any other value.

- **Brightness Range**: The script currently ensures that the brightness level stays within the range of 0 to 1. If your monitor supports a different range of brightness levels, you can modify the checks for the minimum and maximum brightness in the script.

## Compatibility

While this script is designed for Qubes OS with Intel graphics, it can also be used with AMD graphics. The `/sys/class/backlight` directory should contain a subdirectory for your AMD graphics card. You might need to adjust the path in the script to match the correct subdirectory for your specific setup.

Remember, the best way to use this script is to tailor it to your specific setup and preferences. Happy coding!
