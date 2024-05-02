#!/bin/bash

echo -n "Enter IP: "
read -r IP
sudo modprobe -r v4l2loopback
sudo modprobe v4l2loopback video_nr=9 card_label=Video-Loopback exclusive_caps=1
ffmpeg -i http://$IP:8080/video -vf format=yuv420p -f v4l2 /dev/video9
