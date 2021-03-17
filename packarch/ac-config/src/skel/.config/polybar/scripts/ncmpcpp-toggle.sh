#!/bin/bash
if pgrep -x "ncmpcpp" > /dev/null
then
	killall ncmpcpp
else
	alacritty -e ncmpcpp &
fi
