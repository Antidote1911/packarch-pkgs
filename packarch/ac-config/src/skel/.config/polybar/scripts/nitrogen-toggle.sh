#!/bin/bash
if pgrep -x "nitrogen" > /dev/null
then
	killall nitrogen
else
	nitrogen &
fi
