#!/bin/bash
MEM=$(memory_pressure | awk '/percentage/ { printf "%.0f%%", $5 }')
sketchybar --set "$NAME" label="$MEM"
