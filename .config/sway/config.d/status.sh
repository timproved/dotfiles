#!/bin/bash

# Function to get brightness percentage
get_brightness() {
    brightnessctl -m | cut -d',' -f4 | tr -d '%'
}

# Function to get volume percentage and audio output type
get_volume() {
    volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1)
    muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes" && echo "󰝟" || echo "")

    # Check if default sink is bluetooth
    sink_name=$(pactl get-default-sink)
    if pactl list sinks | grep -A 15 "$sink_name" | grep -q "bluetooth"; then
        if [ -n "$muted" ] && [ "$muted" = "󰝟" ]; then
            icon="󰟎" # Bluetooth headphones muted
        else
            icon="󰋋" # Bluetooth headphones
        fi
    else
        icon="$muted" # Regular speaker icon or muted icon
    fi

    echo "$icon $volume%"
}

# Rest of your existing code remains the same
get_battery() {
    if [ -d /sys/class/power_supply/BAT0 ]; then
        capacity=$(cat /sys/class/power_supply/BAT0/capacity)
        status=$(cat /sys/class/power_supply/BAT0/status)
        if [ "$status" = "Charging" ]; then
            icon="󰂄"
        else
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

get_network() {
    # Try NetworkManager first
    if command -v nmcli &>/dev/null; then
        SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
        if [ -n "$SSID" ]; then
            echo "󰖩 $SSID" # WiFi icon
        else
            # Check for ethernet
            ethernet_state=$(nmcli -t -f device,state dev | grep '^eth' | cut -d: -f2)
            if [ "$ethernet_state" = "connected" ]; then
                echo "󰈁 ETH" # Ethernet icon
            else
                echo "󰖪 disconnected" # Disconnected icon
            fi
        fi
    # Try wpa_supplicant if NetworkManager not available
    elif command -v wpa_cli &>/dev/null; then
        SSID=$(wpa_cli status | grep '^ssid=' | cut -d= -f2)
        if [ -n "$SSID" ]; then
            echo "󰖩 $SSID"
        else
            echo "󰖪 disconnected"
        fi
    else
        echo "? unknown"
    fi
}

# Main loop
while true; do
    brightness="󰃞 $(get_brightness)%"
    volume=$(get_volume)
    battery=$(get_battery)
    network=$(get_network)
    date_time="󰃭 $(date +'%d-%m-%Y') | 󰥔 $(date +'%H:%M')"
    # Output the status line
    echo "$brightness | $volume | $battery | $network | $date_time"
    # Update every second
    sleep 1
done
