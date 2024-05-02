#!/bin/bash


date_formatted=$(date "+%H:%M %m.%d")
battery_status=$(cat /sys/class/power_supply/BAT0/capacity)

cat << EOF | tr '\n' ' ' | tr -d "[:blank:]"
{
     "color": #f1f000,
     "full_test": lkjsdklj
}
EOF
