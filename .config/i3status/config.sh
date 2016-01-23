#!/bin/sh

wireless_iface=$(/sbin/iwgetid)
wireless_iface=${wireless_iface%% *}

temperature_path=$(ls -1 /sys/devices/platform/coretemp.0/hwmon/hwmon?/temp?_input | head -n 1)

cat >"${0%.sh}" <<EOF
general {
    colors = true
    interval  = 5
    output_format = i3bar
    markup = pango
    color_good = "#859900"
    color_bad = "#DC322F"
    color_degraded = "#b58900"
}

order += "wireless ${wireless_iface}"
order += "battery 0"
order += "cpu_temperature 0"
order += "cpu_usage"
order += "tztime local"
# order += "disk /"
# order += "load"
# order += "volume Master"

disk "/" {
    format = "<span style='normal'></span> <span style='italic'>%avail</span>"
}

wireless ${wireless_iface} {
    format_up = "<span style='normal'></span> %essid %quality"
    format_down = "<span style='normal'></span> Off"
    color_good = "#9f9f9f"
    color_bad = "#9f9f9f"
}

battery 0 {
    format = "<span style='normal'>%status</span> %percentage %remaining %consumption"
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
