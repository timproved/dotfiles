#!/bin/bash

# Function to get brightness percentage
get_brightness() {
    brightnessctl -m | cut -d',' -f4 | tr -d '%'
}

# Function to get volume percentage
get_volume() {
    # Get volume using pactl (for pipewire/pulseaudio)
    volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1)
    muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes" && echo "󰝟" || echo "")
    echo "$muted $volume%"
}

# Function to get battery percentage
get_battery() {
    # Check if battery exists
    if [ -d /sys/class/power_supply/BAT0 ]; then
        capacity=$(cat /sys/class/power_supply/BAT0/capacity)
        status=$(cat /sys/class/power_supply/BAT0/status)

        # Choose icon based on status
        if [ "$status" = "Charging" ]; then
            icon="󰂄"
        else
            # Choose battery icon based on level
            if [ $capacity -ge 90 ]; then
                icon="󰁹"
            elif [ $capacity -ge 75 ]; then
                icon="󰂀"
            elif [ $capacity -ge 50 ]; then
                icon="󰁾"
            elif [ $capacity -ge 25 ]; then
                icon="󰁼"
            else
                icon="󰁺"
            fi
        fi

        echo "$icon $capacity%"
    else
        echo "No battery"
    fi
}

# Main loop
while true; do
    # Get all stats
    brightness="󰃞 $(get_brightness)%"
    volume=$(get_volume)
    battery=$(get_battery)
    date_time="󰃭 $(date +'%d.%m.%Y') | 󰥔 $(date +'%H:%M:%S')"

    # Output the status line
    echo "$brightness | $volume | $battery | $date_time"

    # Update every second
    sleep 1
done
