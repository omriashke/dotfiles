#!/bin/bash
SHADER_NAME="${1:-starfield-colors}"
CONFIG="$HOME/Development/dotfiles/ghosty"
SHADER="/Users/omriaskenazi/Development/dotfiles/shaders/${SHADER_NAME}.glsl"

if [ ! -f "$SHADER" ]; then
    echo "Shader not found: $SHADER" >&2
    exit 1
fi

if grep -q "^custom-shader" "$CONFIG"; then
    sed -i '' 's/^custom-shader/# custom-shader/' "$CONFIG"
    echo "Shaders disabled"
else
    sed -i '' "s|^# custom-shader = .*|custom-shader = ${SHADER}|" "$CONFIG"
    sed -i '' 's/^# custom-shader-animation/custom-shader-animation/' "$CONFIG"
    echo "Shaders enabled: $SHADER_NAME"
fi

pkill -USR2 ghostty
