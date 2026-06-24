#!/bin/bash
# Seek to position given as 0-100
pct="$1"
len=$(playerctl metadata mpris:length 2>/dev/null) || exit
target=$(echo "$pct $len" | awk '{printf "%.1f", ($1/100)*($2/1000000)}')
playerctl position "$target"
