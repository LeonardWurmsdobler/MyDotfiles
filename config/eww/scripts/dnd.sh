#!/bin/bash
case "$1" in
  toggle)
    if makoctl mode | grep -q 'do-not-disturb'; then
      makoctl mode -r do-not-disturb
    else
      makoctl mode -a do-not-disturb
    fi
    ;;
  status)
    if makoctl mode | grep -q 'do-not-disturb'; then
      echo true
    else
      echo false
    fi
    ;;
esac
