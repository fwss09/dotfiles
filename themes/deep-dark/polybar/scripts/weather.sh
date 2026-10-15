#!/usr/bin/env bash

if [ "$1" = "notify" ]; then
    info=$(curl -s --max-time 4 "wttr.in?format=%C+%t+(feels+like+%f)%0A💨+Wind:+%w%0A💧+Humidity:+%h" 2>/dev/null)
    if [ -n "$info" ]; then
        dunstify -u normal -t 5000 -r 9922 "Weather" "$info"
    else
        dunstify -u low -t 3000 -r 9922 "Weather" "Unable to fetch forecast"
    fi
else
    curl -s --max-time 4 "wttr.in?format=%c+%t" 2>/dev/null | tr -s ' ' || true
fi
