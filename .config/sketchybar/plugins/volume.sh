#!/bin/bash
if [ "$SENDER" = "volume_change" ]; then
    VOLUME="$INFO"
else
    VOLUME=$(osascript -e 'output volume of (get volume settings)')
fi

case $VOLUME in
    [0-9])       ICON="" ;;
    [1-3][0-9])  ICON="" ;;
    *)           ICON="" ;;
esac

sketchybar --set "$NAME" icon="$ICON" label="${VOLUME}%"
