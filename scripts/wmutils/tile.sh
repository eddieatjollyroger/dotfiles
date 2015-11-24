#!/bin/sh
#
# z3bra - 2014 (c) wtfpl
# arrange windows in a tiled pattern

# Resolution
WIDTH=1920
HEIGHT=1080

# default values for gaps and master area
PANEL=0
GAP=100

# Master is half of the screen width minus
MASTER=$((WIDTH / 2 - $((GAP / 2))))

# get current window id and its borderwidth
PFW=$(pfw)
BW=$(wattr b "$PFW")

# get the number of windows to put in the stacking area
MAX=$(lsw | grep -v $PFW | wc -l)

# List number of windows with "tile_ignore" in name
IGNORE=$(wname $(lsw) | grep "tile_ignore" | wc -l)

# calculate usable screen size (without borders and gaps)
SW=$((WIDTH - GAP - 2*BW))
SH=$((HEIGHT - GAP - 2*BW - PANEL))

Y=$((GAP + PANEL))

# put current window in master area

# If windowname includes "tile_ignore", exit
if [[ $(wname $PFW) == *"tile_ignore"* ]]; then
    exit

# If there's only one unignored window open tile it to the full width of the screen
elif [[ $(($(lsw | wc -l) - $IGNORE)) == 1 ]]; then
    SW=$((SW - GAP))
    SH=$((SH - GAP))
    wtp $GAP $GAP $SW $SH $PFW

# Prevent tiling of ignored windows
else
    wtp $GAP $Y $((MASTER - GAP - 2*BW)) $((SH - GAP)) $PFW
fi

# Put the tiled windows at the bottom of the stack
chwso -l $PFW

# and now, stack up all remaining windows on the right
X=$((MASTER + GAP))
W=$((SW - MASTER - GAP))
H=$((SH / $((MAX - IGNORE)) - GAP))

for wid in $(lsw | grep -v $PFW); do
    # If focused window's name doesn't include "tile_ignore", tile it!
    if [[ $(wname $wid) != *"tile_ignore"* ]]; then
        wtp $X $Y $W $H $wid
        Y=$((Y + H + GAP))

        # Put the tiled windows at the bottom of the stack
        chwso -l $wid
    fi
done
