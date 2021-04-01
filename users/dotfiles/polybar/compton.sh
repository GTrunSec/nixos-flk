#!/usr/bin/env sh

# Terminate already running bar instances
kill -9 $(pgrep compton)

# Wait until the processes have been shut down
while pgrep -u $UID -x compton >/dev/null; do sleep 1; done

compton --config /home/gtrun/.compton.conf &
