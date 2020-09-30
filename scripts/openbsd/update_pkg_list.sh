#/usr/bin/local/env bash

LIST=${HOME}/list
PORTS=/usr/ports
DEBUG=1

refresh_list() {
    pkg_info -mz | sed 's/\-.*//' > ${LIST}
}

pkg_prefix() {
    base=`dirname "$1"`
    pref=`basename "$base"`
	if [ "$DEBUG" -gt 0 ]; then
		echo "--------------------"
        echo "Processing pkg: $pkg"
	    echo "-> PREFIX: $pref"
	    echo "-> PKG: $2"
		echo "--------------------"
    fi
	sed -i "s/"$2"/"$pref"\/&/" ${LIST}
}

show_list() {
    cat ${LIST}
}

rebuild_pkg_list() {
    while read pkg; do
		cur_pkg=`find ${PORTS} -maxdepth 2 -type d -name $pkg | sed 1q`
	    pkg_prefix "$cur_pkg" "$pkg"	
    done < ${LIST}
}



refresh_list
rebuild_pkg_list
show_list
