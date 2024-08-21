#!/bin/bash

URL=https://bing.biturl.top/\?resolution\=3840\&format\=json\&mkt\=random
IMAGES_DIR=$HOME/places/sys/wallpapers
TODAY_WALLPAPER=$IMAGES_DIR/$(date +%Y%m%d).jpg

bg_set() {
    swaybg --image $TODAY_WALLPAPER --output "*" --mode fill
}

pkill swaybg
if [[ -f $TODAY_WALLPAPER ]]; then
    bg_set
else
    wget $(curl $URL | jq -r '.url') -O $TODAY_WALLPAPER && bg_set
fi
