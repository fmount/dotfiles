#!/bin/bash
WEATHER=$(curl -sS 'https://wttr.in?0&T&Q' 2>/dev/null | cut -c 16- | head -2 | xargs echo)

if [ -n "$WEATHER" ]; then
    sketchybar --set "$NAME" label="$WEATHER"
else
    sketchybar --set "$NAME" label="..."
fi
