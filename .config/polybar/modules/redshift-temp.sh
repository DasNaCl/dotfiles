#!/bin/sh

if [ "$(pgrep -x redshift)" ]; then
    temp=$(redshift -p -l 47:13 2> /dev/null | grep temp | cut -d ":" -f 2 | tr -dc "[:digit:]")

    if [ -z "$temp" ]; then
        echo "%{F#65737E} 💡"
    elif [ "$temp" -ge 5000 ]; then
        echo "%{F#8FA1B3} 💡"
    elif [ "$temp" -ge 4000 ]; then
        echo "%{F#EBCB8B} 💡"
    else
        echo "%{F#D08770} 💡"
    fi
fi

