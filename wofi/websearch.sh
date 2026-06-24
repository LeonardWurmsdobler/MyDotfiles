#!/bin/bash
query=$(wofi --dmenu --prompt "Search web...")
if [ -n "$query" ]; then
  firefox "https://google.com/search?q=$(echo $query | sed 's/ /+/g')"
fi
