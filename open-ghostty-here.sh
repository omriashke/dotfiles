#!/bin/bash

CURRENT_WINDOW=$(aerospace list-windows --focused --format '%{window-id}' 2>/dev/null)

open -na Ghostty

sleep 0.3

if [ -n "$CURRENT_WINDOW" ]; then
    aerospace focus --window-id "$CURRENT_WINDOW"
fi
