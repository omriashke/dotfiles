#!/bin/bash
SHADER_LINK="$HOME/.config/ghostty/shaders.conf"
SHADER_SOURCE="$HOME/Development/dotfiles/ghosty-shaders.conf"

if [ -e "$SHADER_LINK" ]; then
    rm "$SHADER_LINK"
else
    ln -sf "$SHADER_SOURCE" "$SHADER_LINK"
fi

sleep 0.2
osascript -e 'tell application "System Events" to keystroke "," using {command down, shift down}'
