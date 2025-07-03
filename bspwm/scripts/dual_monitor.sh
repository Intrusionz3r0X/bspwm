#!/bin/bash

if [[ $(xrandr -q | grep -w connected | wc -l) -eq 2 ]];then
        xrandr --output Virtual2 --primary --mode 1920x1080 --rotate normal --output Virtual1 --mode 1920x1080 --rotate normal --left-of Virtual2
		bspc monitor Virtual2 -d II III IV V VI VII VIII IX X
		bspc monitor Virtual1 -d I
elif [[ $(xrandr -q | grep -w connected | wc -l) -eq 1 ]];then
        bspc monitor -d I II III IV V VI VII VIII IX X
fi
