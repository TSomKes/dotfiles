#!/usr/bin/env bash

volume() {

    volumeIcon=$'\xf0\x9f\x94\x8a'
    muteIcon=$'\xf0\x9f\x94\x87'

    volumeLevel=$(amixer sget Master \
        | awk -F"[][]" '/Left:/ { print $2 }' \
        | sed "s/[^0-9]//g")

    volumeState=$(amixer sget Master \
        | awk '/Left:/ {print $6}' \
        | sed "s/[^a-z]//g")

    if [ "$volumeState" = 'off' ]; then
        echo "$muteIcon $volumeLevel"m
    else
        echo "$volumeIcon $volumeLevel"
    fi
}

brightness() {
    
    brightnessIcon=$'\xe2\x98\xbc'

    # Screen brightness
    #MAX_BRIGHT=`cat /sys/class/backlight/intel_backlight/max_brightness`
    #BRIGHT=`cat /sys/class/backlight/intel_backlight/actual_brightness`
    #RELATIVE_BRIGHT=$((100 * $BRIGHT / $MAX_BRIGHT))

    brightnessRaw=$(light)
    brightness=${brightnessRaw%.*}  # --> int, strip at decimal point

    echo "$brightnessIcon $brightness"
}

battery() {

    batteryIcon=$'\xf0\x9f\x94\x8b'

    batteryCapacity=$(cat /sys/class/power_supply/BAT0/capacity)

    batteryStatus=$(cat /sys/class/power_supply/BAT0/status)
    batteryStatusSymbol=''

    if [[ $batteryStatus == 'Charging' ]]; then
        batteryStatusSymbol='+'
    elif [[ $batteryStatus == 'Discharging' ]]; then
        batteryStatusSymbol='-'
    fi

    echo "$batteryIcon $batteryCapacity$batteryStatusSymbol"
}

datetime() {
    date +"%Y-%m-%d %a %R"
}

while true; do
    xsetroot -name "  $(volume) | $(brightness) | $(battery) | $(datetime)  "
    sleep 30
done
