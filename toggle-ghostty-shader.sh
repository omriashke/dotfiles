#!/bin/bash
SHADER_NAME="${1:-starfield-colors}"
CONFIG="$HOME/Development/dotfiles/ghosty"
SHADER="/Users/omriaskenazi/Development/dotfiles/shaders/${SHADER_NAME}.glsl"

if [ ! -f "$SHADER" ]; then
    echo "Shader not found: $SHADER" >&2
    exit 1
fi

CURRENT=$(grep "^custom-shader = " "$CONFIG" | head -1 | sed 's/custom-shader = //')

if [ "$CURRENT" = "$SHADER" ]; then
    # Same shader is active — toggle it off
    sed -i '' "s|^custom-shader = .*|# custom-shader = ${SHADER}|" "$CONFIG"
    sed -i '' 's/^custom-shader-animation/# custom-shader-animation/' "$CONFIG"
    echo "Shaders disabled"
elif [ -n "$CURRENT" ]; then
    # Different shader is active — switch to the new one
    sed -i '' "s|^custom-shader = .*|custom-shader = ${SHADER}|" "$CONFIG"
    echo "Shader switched: $SHADER_NAME"
else
    # Shaders are disabled — enable with the requested shader
    sed -i '' "s|^# custom-shader = .*|custom-shader = ${SHADER}|" "$CONFIG"
    sed -i '' 's/^# custom-shader-animation/custom-shader-animation/' "$CONFIG"
    echo "Shader enabled: $SHADER_NAME"
fi

pkill -USR2 ghostty
