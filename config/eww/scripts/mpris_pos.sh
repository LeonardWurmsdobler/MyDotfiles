#!/bin/bash
# Returns playback position as 0-100
pos=$(playerctl position 2>/dev/null) || { echo 0; exit; }
len=$(playerctl metadata mpris:length 2>/dev/null) || { echo 0; exit; }
echo "$pos $len" | awk '{len_sec=$2/1000000; if(len_sec==0){print 0}else{printf "%d", ($1/len_sec)*100}}'
