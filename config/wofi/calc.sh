#!/bin/bash
result=$(echo "" | wofi --dmenu --prompt "Calculate:")
answer=$(echo "$result" | bc -l 2>/dev/null)
notify-send "Result" "$result = $answer"
