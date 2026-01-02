#!/usr/bin/env bash

CMD="swaymsg output"

function get_outputs() {
    swaymsg -t get_outputs -r | jq -r '.[] | select(.active == true) | .name'
}

function get_primary() {
    # Try to find eDP (laptop screen) first
    swaymsg -t get_outputs -r | jq -r '.[] | select(.name | startswith("eDP")) | .name' | head -n1
}

function get_external() {
    local primary="$1"
    swaymsg -t get_outputs -r | jq -r ".[] | select(.name != \"$primary\") | .name" | head -n1
}

function get_resolution() {
    local output="$1"
    swaymsg -t get_outputs -r | jq -r ".[] | select(.name == \"$output\") | .current_mode | \"\(.width)x\(.height)\""
}

function screenclone() {
    local src="${1:-eDP-1}"

    # Get source resolution
    local srcres=$(get_resolution "$src")

    # Get all external outputs
    for out in $(swaymsg -t get_outputs -r | jq -r ".[] | select(.name != \"$src\") | .name"); do
        local outres=$(get_resolution "$out")

        # Enable both outputs with same resolution (mirrored)
        swaymsg output "$out" enable
        swaymsg output "$out" position 0,0
        swaymsg output "$src" position 0,0
    done
}

function screenconnect() {
    local direction="left"
    local src="eDP-1"

    if [[ "$1" == "r" ]]; then
        direction="right"
    fi

    if [[ ! -z "$2" ]]; then
        src="$2"
    fi

    # Get primary output resolution
    local srcres=$(get_resolution "$src")
    local src_width=$(echo "$srcres" | cut -d'x' -f1)

    # Position external outputs
    local position=0
    for out in $(swaymsg -t get_outputs -r | jq -r ".[] | select(.name != \"$src\") | .name"); do
        swaymsg output "$out" enable

        if [[ "$direction" == "left" ]]; then
            local outres=$(get_resolution "$out")
            local out_width=$(echo "$outres" | cut -d'x' -f1)
            swaymsg output "$out" position $((position - out_width)),0
            position=$((position - out_width))
        else
            swaymsg output "$out" position "$src_width",0
            local outres=$(get_resolution "$out")
            local out_width=$(echo "$outres" | cut -d'x' -f1)
            src_width=$((src_width + out_width))
        fi
    done

    # Position primary
    swaymsg output "$src" enable position 0,0
}

function single_monitor_clone() {
    PRIMARY="${PRIMARY:-eDP-1}"

    # Try to auto-detect primary if not set
    if [[ "$PRIMARY" == "eDP-1" ]]; then
        PRIMARY=$(get_primary)
        [[ -z "$PRIMARY" ]] && PRIMARY="eDP-1"
    fi

    TARGET=$(get_external "$PRIMARY")

    # If no external output found, try common names
    if [[ -z "$TARGET" ]]; then
        for name in DP-1 DP-2 HDMI-A-1 HDMI-A-2; do
            if swaymsg -t get_outputs -r | jq -e ".[] | select(.name == \"$name\")" > /dev/null 2>&1; then
                TARGET="$name"
                break
            fi
        done
    fi

    case "$1" in
        "init")
            PRIMARY=$(get_primary)
            echo $PRIMARY
            LID_OUTPUT=$(cat /proc/acpi/button/lid/LID/state | grep -i open)
            if [[ -z "$LID_OUTPUT" ]]; then
                swaymsg output "$PRIMARY" disable
            fi
            ;;
        "dock")
            TARGET=$(get_external "$PRIMARY")
            PRIMARY=$(get_primary)
            # Disable laptop screen, enable external as primary
            swaymsg output "${PRIMARY}" disable
            swaymsg output "${TARGET}" enable
            swaymsg output "${TARGET}" position 0,0
            ;;
        "undock")
            # Disable external, enable laptop screen
            swaymsg output "${TARGET}" disable
            swaymsg output "${PRIMARY}" enable
            swaymsg output "${PRIMARY}" position 0,0
            ;;
        "together")
            POSITION="${2:-right}"
            # Enable both outputs
            swaymsg output "${PRIMARY}" enable position 0,0
            swaymsg output "${TARGET}" enable

            # Get primary resolution for positioning
            local prim_res=$(get_resolution "$PRIMARY")
            local prim_width=$(echo "$prim_res" | cut -d'x' -f1)

            if [[ "$POSITION" == "right" ]]; then
                swaymsg output "${TARGET}" position "$prim_width",0
            elif [[ "$POSITION" == "left" ]]; then
                local tgt_res=$(get_resolution "$TARGET")
                local tgt_width=$(echo "$tgt_res" | cut -d'x' -f1)
                swaymsg output "${TARGET}" position "-$tgt_width",0
            elif [[ "$POSITION" == "above" ]]; then
                local tgt_res=$(get_resolution "$TARGET")
                local tgt_height=$(echo "$tgt_res" | cut -d'x' -f2)
                swaymsg output "${TARGET}" position "0,-$tgt_height"
            elif [[ "$POSITION" == "below" ]]; then
                local prim_height=$(echo "$prim_res" | cut -d'x' -f2)
                swaymsg output "${TARGET}" position "0,$prim_height"
            fi
            ;;
        "duplicate"|"panic")
            # Mirror/clone displays - both at position 0,0
            swaymsg output "${PRIMARY}" enable position 0,0
            swaymsg output "${TARGET}" enable position 0,0
            ;;
        "left")
            # External on left of laptop
            swaymsg output "${PRIMARY}" enable position 0,0
            swaymsg output "${TARGET}" enable

            local tgt_res=$(get_resolution "$TARGET")
            local tgt_width=$(echo "$tgt_res" | cut -d'x' -f1)
            swaymsg output "${TARGET}" position "-$tgt_width",0
            ;;
        "right")
            # External on right of laptop
            swaymsg output "${PRIMARY}" enable position 0,0
            swaymsg output "${TARGET}" enable

            local prim_res=$(get_resolution "$PRIMARY")
            local prim_width=$(echo "$prim_res" | cut -d'x' -f1)
            swaymsg output "${TARGET}" position "$prim_width",0
            ;;
        *)
            echo "Usage: $0 {dock|undock|together [left|right|above|below]|duplicate|panic|left|right}"
            exit 1
            ;;
    esac
}

single_monitor_clone "$@"
