#!/bin/bash
BATT=$(pmset -g batt)
PERCENT=$(echo "$BATT" | grep -oE '[0-9]+%' | head -1)
CHARGING=$(echo "$BATT" | grep -c 'AC Power')

if [ -z "$PERCENT" ]; then
    sketchybar --set "$NAME" drawing=off
    exit 0
fi

PCT=${PERCENT%\%}
if [ "$CHARGING" -gt 0 ]; then
    ICON=""
elif [ "$PCT" -ge 80 ]; then
    ICON=""
elif [ "$PCT" -ge 60 ]; then
    ICON=""
elif [ "$PCT" -ge 40 ]; then
    ICON=""
elif [ "$PCT" -ge 20 ]; then
    ICON=""
else
    ICON=""
fi

sketchybar --set "$NAME" icon="$ICON" label="$PERCENT" drawing=on
