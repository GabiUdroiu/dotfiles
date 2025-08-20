#!/bin/bash

case "$1" in
  on)
    gammastep -O 3700 &
    ;;
  off)
    killall gammastep
    ;;
  *)
    echo "Usage: $0 {on|off}"
    exit 1
    ;;
esac

