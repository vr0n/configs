#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

bat() {
	char=$(upower --dump | grep percentage | uniq | awk '/percentage/ {printf "%d", $2}')
	state=$(upower --dump | grep state | uniq | awk '/state/ {printf "%s", $2}')

	echo -e "BAT: $char% - $state"
}

mem() {
	free -h | awk '/Mem/ {printf "MEM: %s/%s", $3, $2}'
}

dat() {
	date +'%F %H:%M'
}

cpu() {
	read cpu a b c previdle rest < /proc/stat
	prevtotal=$((a+b+c+previdle))
	sleep 0.5
	read cpu a b c idle rest < /proc/stat
	sleep 0.5
	total=$((a+b+c+idle))
	cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
	printf "CPU: %2d%%" $cpu
}

vol() {
	VAL="$(amixer get Master | awk '/Front Right:/ {print $6}' | tr -d '[]')"

	if [ "$VAL" != "off" ]; then
		VAL="$(amixer get Master | awk '/Front Right:/ {print $5}' | tr -d '[]')"
	fi

	printf "VOL: %s" $VAL
}

# stop function definitions.
# begin script stuff...

#~/.config/rfs.sh

compton &
feh --bg-scale ~/Documents/papes/fish.jpg &

while [ 1 ]; do
	xsetroot -name " $(bat) | $(cpu) | $(mem) | $(vol) | $(dat) "
	sleep 10s
done &
