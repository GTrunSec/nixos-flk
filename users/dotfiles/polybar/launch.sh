#!/bin/sh

# Terminate already running bar instances
kill -9 $(pgrep polybar)
# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
for monitor in $(polybar --list-monitors | cut -d ":" -f1); do
    MONITOR=$monitor polybar top --reload --quiet &
    MONITOR=$monitor polybar bottom --reload --quiet &
done 

echo "Bars launched..."
dunstify -u low  "Bars launched"

