#!/bin/bash

get_brightness() {
    brightnessctl -m | cut -d',' -f4 | tr -d '%'
}

get_volume() {
    volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1)
    muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes" && echo "󰝟" || echo "󰕾")
    sink_name=$(pactl get-default-sink)
    if pactl list sinks | grep -A 15 "$sink_name" | grep -q "bluetooth"; then
        [ "$muted" = "󰝟" ] && icon="󰟎" || icon="󰋋"
    else
        icon="$muted"
    fi
    echo "$icon $volume%"
}

get_battery() {
    if [ -d /sys/class/power_supply/BAT0 ]; then
        capacity=$(cat /sys/class/power_supply/BAT0/capacity)
        status=$(cat /sys/class/power_supply/BAT0/status)
        icon=$([ "$status" = "Charging" ] && echo "󰂄" ||
            ([ $capacity -ge 90 ] && echo "󰁹" ||
                [ $capacity -ge 75 ] && echo "󰂀" ||
                [ $capacity -ge 50 ] && echo "󰁾" ||
                [ $capacity -ge 25 ] && echo "󰁼" || echo "󰁺"))
        echo "$icon $capacity%"
    fi
}

get_network() {
    # Check NetworkManager
    if command -v nmcli >/dev/null; then
        state=$(nmcli -t -f STATE g)
        if [ "$state" = "connected" ]; then
            connection=$(nmcli -t -f TYPE,NAME c show --active | head -n1)
            case $connection in
            *wireless*)
                strength=$(nmcli -f IN-USE,SIGNAL dev wifi | awk '/^\*/{print $2}')
                [ $strength -ge 75 ] && icon="󰤨" ||
                    [ $strength -ge 50 ] && icon="󰤥" ||
                    [ $strength -ge 25 ] && icon="󰤢" || icon="󰤟"
                name=$(echo "$connection" | cut -d: -f2)
                echo "$icon $name"
                ;;
            *ethernet*)
                echo "󰈁 $(echo "ETH" | cut -d: -f2)"
                ;;
            esac
            return
        fi
    fi

    # Check wpa_supplicant
    if pidof wpa_supplicant >/dev/null; then
        interface=$(find /sys/class/net -type l -not -lname '*virtual*' -exec basename {} \;)
        for i in $interface; do
            if [ -d "/sys/class/net/$i/wireless" ]; then
                if iwconfig "$i" 2>/dev/null | grep -q 'ESSID:.*".*"'; then
                    strength=$(awk 'NR==3 {print int($3 * 100 / 70)}' "/proc/net/wireless")
                    [ $strength -ge 75 ] && icon="󰤨" ||
                        [ $strength -ge 50 ] && icon="󰤥" ||
                        [ $strength -ge 25 ] && icon="󰤢" || icon="󰤟"
                    name=$(iwconfig "$i" | grep ESSID | cut -d'"' -f2)
                    echo "$icon $name"
                    return
                fi
            elif ethtool "$i" 2>/dev/null | grep -q 'Link detected: yes'; then
                echo "󰈁 $i"
                return
            fi
        done
    fi
    echo "󰤭 disconnected"
}

while true; do
    brightness="󰃞 $(get_brightness)%"
    volume=$(get_volume)
    battery=$(get_battery)
    network=$(get_network)
    datetime="󰃭 $(date +'%d-%m-%Y')| 󰥔  $(date +'%H:%M')"

    echo " $volume | $network | $datetime"
    sleep 1
done
