!#/bin/sh

RED='\033[0;31m'
NC='\033[0m'
PF="$(uname)"

# Define platform agnostic functions
dat() {
	date +'%F %H:%M'
}

# Define functions based on platform since we are a BSD boi now.
if [ "$PF" == "Linux" ]; then
	bat() {
		char=$(upower --dump | grep percentage | uniq | awk '/percentage/ {printf "%d", $2}')
		state=$(upower --dump | grep state | uniq | awk '/state/ {printf "%s", $2}')
	
		echo -e "BAT: $char% - $state"
	}
	
	mem() {
		free -h | awk '/Mem/ {printf "MEM: %s/%s", $3, $2}'
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
elif [ "$PF" == "OpenBSD" ]; then
	bat() {
		char=$(apm -l)

		if [ $(apm -a) ]; then
			state="charging"
		else
			state="discharging"
		fi
	
		echo -e "BAT: $char% - $state"
	}
	
	mem() {
		mem=$(top | grep Memory | awk '{print $3}')

		printf "MEM: %s" $mem
	}
	
	cpu() {
		cpu="$(top | grep ^CPU[0-9]* | awk '{sum+=$13} END{print 100-(sum/2);}')"
		printf "CPU: %.2f%%" $cpu
	}
	
	vol() {
		vol="$(sndioctl | grep output.level | awk -F '=' '{print $2*100}')"
	
		printf "VOL: %s%%" $vol
	}
fi

# stop function definitions.
# begin script stuff...

#~/.config/rfs.sh

#compton &
picom &
# path to pape
feh --bg-scale ~/configs/papes/win95.jpg &

while [ 1 ]; do
	xsetroot -name " $(bat) | $(cpu) | $(mem) | $(vol) | $(dat) "
	sleep 5
done &
