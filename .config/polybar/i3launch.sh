#!/bin/bash

# Terminate running bar instances
killall -q polybar

# Wait until proceses have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar i3top &
