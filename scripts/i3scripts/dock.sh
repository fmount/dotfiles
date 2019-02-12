#! /bin/bash

MODE=("auto" "off")
CMD="$(command -v xrandr)"

PRIMARY="eDP1"
TARGET="DP2"


case "$1" in
    "dock")
        ${CMD} --output "${PRIMARY}" --"${MODE[1]}" --output "${TARGET}" --"${MODE[0]}" \
            --primary ;;
    "undock")
        ${CMD} --output "${TARGET}" --"${MODE[1]}" --output "${PRIMARY}" --"${MODE[0]}" \
            --primary ;;
    "together")
        POSITION="$2"
        ${CMD} --output "${TARGET}" --"${MODE[0]}" --"${POSITION}""-of" "$PRIMARY" ;;
    "duplicate")
        ${CMD} --output "${TARGET}" --same-as "${PRIMARY}"
        ;;
    "panic")
        ${CMD} --output "${TARGET}" --same-as "${PRIMARY}" ;;
esac
