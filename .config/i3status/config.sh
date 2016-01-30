#!/bin/sh

config_sh="$0"
config_file="${0%.sh}"

if [ -e "$config_file" -a "$config_file" -nt "$config_sh" ]; then
    exit 0
fi

# Wireless
if [ -e /sbin/iwconfig -a x"$(/sbin/iwconfig 2>/dev/null)" != x ]; then
    enable_wireless="true"
fi

# Battery
if [ -e /sys/class/power_supply/BAT0 ]; then
    enable_battery="true"
fi

# Temperature
temperature_path=$(ls -1 /sys/devices/platform/coretemp.0/hwmon/hwmon?/temp?_input | head -n 1)

(
test x"$enable_wireless" = x"true" && echo 'order += "wireless _first_"'
test x"$enable_battery" = x"true" && echo 'order += "battery 0"'
cat <<EOF
order += "cpu_temperature 0"
order += "cpu_usage"
order += "tztime local"
# order += "disk /"
# order += "load"
# order += "volume Master"

general {
    colors = true
    interval  = 5
    output_format = i3bar
    markup = pango
    color_good = "#859900"
    color_bad = "#DC322F"
    color_degraded = "#b58900"
}

disk "/" {
    format = "<span style='normal'></span> <span style='italic'>%avail</span>"
}

wireless _first_ {
    format_up = "<span style='normal'></span> %essid %quality"
    format_down = "<span style='normal'></span> Off"
    color_good = "#9f9f9f"
    color_bad = "#9f9f9f"
}

battery 0 {
    format = "<span style='normal'>%status</span> %percentage %remaining"
    integer_battery_capacity = true
    hide_seconds = true
    low_threshold = 30
    threshold_type = percentage
    status_chr = " "
    status_bat = ""
    status_full = ""
}

cpu_temperature 0 {
    format = "<span style='normal'></span> %degrees°C"
    path = "$temperature_path"
}

cpu_usage {
    format = "%usage"
}

tztime local {
    format = "<span style='normal'></span> %time"
    format_time = "%b %d %H:%M:%S"
}

load {
    format = "%1min"
    max_threshold = "1.5"
}

volume Master {
    format = "<span style='normal'></span> %volume"
    format_muted = "<span style='normal'></span> %volume"
    mixer = "Master"
}
EOF
) >"$config_file"
