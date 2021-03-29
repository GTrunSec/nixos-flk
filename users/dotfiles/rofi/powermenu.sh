#!/bin/bash
action=$(echo -e "lock\nlogout\nshutdown\nreboot\nscreen off" | rofi -dmenu -p "power:")

if [[ "$action" == "lock" ]]
then
    ~/.i3/i3lock-fancy-multimonitor/lock
fi

if [[ "$action" == "screen off" ]]
then
    xset dpms force off
fi

if [[ "$action" == "logout" ]]
then
    i3-msg exit
fi

if [[ "$action" == "shutdown" ]]
then
    shutdown now
fi

if [[ "$action" == "reboot" ]]
then
    reboot
fi
