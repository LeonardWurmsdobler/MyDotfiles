#!/bin/bash

art_url=$(playerctl metadata mpris:artUrl 2>/dev/null)
status=$(playerctl status 2>/dev/null)

if [ "$status" = "Stopped" ] || [ -z "$art_url" ]; then
    echo ""
    exit 0
fi

art_url=$(echo "$art_url" | sed 's/file:\/\///g')

if [[ "$art_url" == /* ]]; then
    if [ -f "$art_url" ]; then
        echo "$art_url"
        exit 0
    else
        echo ""
        exit 0
    fi
fi

# Web URL — download with curl
cache_dir="/tmp/eww_cover"
mkdir -p "$cache_dir"
cover_path="$cache_dir/cover.png"
url_file="$cache_dir/last_url.txt"

if [ -f "$url_file" ]; then
    last_url=$(cat "$url_file")
    if [ "$last_url" = "$art_url" ] && [ -f "$cover_path" ]; then
        echo "$cover_path"
        exit 0
    fi
fi

curl -s --max-time 3 -o "$cover_path" "$art_url" && echo "$art_url" > "$url_file"

if [ -f "$cover_path" ]; then
    echo "$cover_path"
else
    echo ""
fi
