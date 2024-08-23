#!/bin/bash

URL=https://bing.biturl.top/\?resolution\=3840\&format\=json\&mkt\=random
IMAGES_DIR=$HOME/places/sys/wallpapers
WALLPAPER=$IMAGES_DIR/$(date +%Y%m%d)_blurred.jpg

pause_some_stuff() {
    playerctl pause
    keepassxc --lock
}

if ! pgrep swaylock; then
    if [[ -f $WALLPAPER ]]; then
        pause_some_stuff
        swaylock -i $WALLPAPER
    else
        ORIG=$(mktemp)
        wget $(curl $URL | jq -r '.url') -O $ORIG
        if [ $? = "0" ]; then
            convert $ORIG -filter Gaussian -blur 0x9 $WALLPAPER
            pause_some_stuff
            swaylock -i $WALLPAPER
        else
            pause_some_stuff
            swaylock # fallback if no internet or smth
        fi
    fi
else
    break
fi
