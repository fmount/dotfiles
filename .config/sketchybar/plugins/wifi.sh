#!/bin/bash
if [ "$SENDER" = "wifi_change" ]; then
    SSID="$INFO"
else
    SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I 2>/dev/null | awk -F': ' '/ SSID/ {print $2}')
fi

if [ -z "$SSID" ] || [ "$SSID" = "" ]; then
    sketchybar --set "$NAME" icon="" label="off"
else
    sketchybar --set "$NAME" icon="" label="$SSID"
fi
