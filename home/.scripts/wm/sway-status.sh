#!/bin/bash

echo '{"version":1}'
echo '['

body() {
    cat <<- EOF | jq --compact-output --monochrome-output
    [
        {
            "full_text": "$(date "+%H:%M")",
            "color": "#c5c8c6",
            "separator_block_width": 16
        },
        {
            "full_text": "$(date "+%m.%d")",
            "color": "#c5c8c6",
            "separator_block_width": 16
        },
        {
            "full_text": "$(cat /sys/class/power_supply/BAT0/capacity)%",
            "color": "#c5c8c6",
            "separator_block_width": 16
        }
    ]
EOF
}

while :;
do
    echo "$(body),"
	sleep 1
done
