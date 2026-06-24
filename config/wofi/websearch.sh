#!/bin/bash
query=$(wofi --dmenu --prompt "Search web...")
if [ -n "$query" ]; then
  chromium "https://google.com/search?q=$(echo $query | sed 's/ /+/g')"
fi
