#!/bin/bash

URL=https://bing.biturl.top/\?resolution\=3840\&format\=json\&mkt\=random
IMAGES_DIR=$HOME/places/sys/wallpapers
TODAY_WALLPAPER=$IMAGES_DIR/$(date +%Y%m%d).jpg

download() {
    wget $(curl --silent $URL | jq -r '.url') -O $TODAY_WALLPAPER 
}

check() {
    test -f $TODAY_WALLPAPER
}

set() {
    swaybg --image $TODAY_WALLPAPER --output "*" --mode fill
}

pkill swaybg
(check || download) && set
