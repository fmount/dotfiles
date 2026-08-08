#!/bin/bash
VPN=$(scutil --nc list 2>/dev/null | grep Connected | head -1 | sed 's/.*"\(.*\)".*/\1/')

if [ -n "$VPN" ]; then
    sketchybar --set "$NAME" label="$VPN" drawing=on
else
    sketchybar --set "$NAME" label="" drawing=off
fi
