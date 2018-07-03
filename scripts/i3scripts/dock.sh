#! /bin/bash

MODE=("auto" "off")
CMD=$(which xrandr)

PRIMARY="eDP1"
TARGET="DP2"

dock() {
    
	${CMD} --output "${PRIMARY}" --"${MODE[1]}" --output "${TARGET}" --"${MODE[0]}" --primary

}

undock() {

    ${CMD} --output "${TARGET}" --"${MODE[1]}" --output "${PRIMARY}" --"${MODE[0]}" --primary
}


together() {
	
	POSITION="$1"
	${CMD} --output "${TARGET}" --"${MODE[0]}" --"${POSITION}""-of" "$PRIMARY"
}


duplicate() {

    ${CMD} --output "${TARGET}" --same-as "${PRIMARY}"
}


external() {

	echo "PASS"
}


case "$1" in

	"dock")
		dock
		;;
	"undock")
		undock
		;;
	"together")
		together "$2"
		;;
	"duplicate")
		duplicate
		;;
	"panic")
		undock
		;;
esac


#[[ "connected" = $(cat /sys/class/drm/card0/card0-${MON}/status) ]] && dock "eDP1" || undock "eDP1"
