#!/bin/bash

DISPLAY_X=$(xrandr | awk '/current/ {print $8}')
DISPLAY_Y=$(xrandr | awk '/current/ {print $10}' | cut -d, -f1)

i3-msg "[class=\"(?i)weechat\"] move to scratchpad"
i3-msg "[class=\"(?i)weechat\"] resize set $((${DISPLAY_X} * 70 /100))  $((${DISPLAY_Y} * 85 / 100))"
i3-msg "[class=\"(?i)weechat\"] move position $((${DISPLAY_X} * 10 / 100)) $((${DISPLAY_Y} * 8 / 100))"
i3-msg "[class=\"(?i)weechat\"] scratchpad show"
