#! /bin/env bash

MODE=("auto" "off")
CMD="$(command -v xrandr)"

function screenclone() {
    local src="eDP1"
    if [[ ! -z "$1" ]]; then
        src="$1"
    fi
    # determine the optimal source resolution
    local srcres=$(xrandr | grep -A 1 "$src" | tail -1 | awk '{ print $1; }')

    # determine outputs and their optimal resolution
    for out in $(xrandr | grep '\Wconnected' | grep -v "$src" | awk '{ print $1; }'); do
        outres=$(xrandr | grep -A 1 "$out" | tail -1 | awk '{ print $1; }')
        "${CMD}" --output "$out" --off
        "${CMD}" --output "$src" --auto --output "$out" --mode "$outres" --scale-from "$srcres" \
            --panning "$srcres" --set "Broadcast RGB" "Automatic" --set audio force-dvi --same-as "$src"
    done
}


function screenconnect() {
    local src="eDP1"
    local left=1
    if [[ "r" = "$1" ]]; then
        left=0
    fi
    if [[ ! -z "$2" ]]; then
        src="$2"
    fi

    # determine outputs
    for out in $(xrandr | awk '/\Wconnected/ {print $1}' | grep -v "$src"); do
        "${CMD}" --output "$out" --off
        if [[ $left -eq 1 ]]; then
            "${CMD}" --output "$src" --auto --primary --output "$out" --auto --left-of "$src" \
                --panning 0x0 --set "Broadcast RGB" "Automatic" --set audio force-dvi
        else
            "${CMD}" --output "$src" --auto --primary --output "$out" --auto --right-of "$src" \
                --panning 0x0 --set "Broadcast RGB" "Automatic" --set audio force-dvi
        fi
        left=$((1 - $left))
    done
}


function single_monitor_clone() {
    PRIMARY=${PRIMARY:-"eDP1"}
    TARGET=$("$CMD" | awk '/\Wconnected/ {print $1}' | grep -v "$PRIMARY")
    case "$1" in
        "dock")
            ${CMD} --output "${PRIMARY}" --"${MODE[1]}" --output "${TARGET}" --"${MODE[0]}" \
                --primary
            ;;
        "undock")
            ${CMD} --output "${TARGET}" --"${MODE[1]}" --output "${PRIMARY}" --"${MODE[0]}" \
                --primary
            ;;
        "together")
            POSITION="$2"
            ${CMD} --output "${TARGET}" --"${MODE[0]}" --"${POSITION}""-of" "$PRIMARY" 
            ;;
        "duplicate")
            ${CMD} --output "${TARGET}" --same-as "${PRIMARY}"
            ;;
        "panic")
            ${CMD} --output "${TARGET}" --same-as "${PRIMARY}" 
            ;;
        "left")
            ${CMD} --output "${PRIMARY}" --auto --primary --output "${TARGET}" --auto --left-of "${PRIMARY}" --panning 0x0 \
                --set audio force-dvi
            ;;
        "right")
            ${CMD} --output "${PRIMARY}" --auto --primary --output "${TARGET}" --auto --right-of "${PRIMARY}" --panning 0x0 \
                --set \"Broadcast RGB\"Automatic --set audio force-dvi
            ;;
    esac
}

single_monitor_clone "$@"
