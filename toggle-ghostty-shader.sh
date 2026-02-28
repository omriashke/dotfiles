#!/bin/bash
SHADER_NAME="${1:-starfield-colors}"
CONF_PATH="$HOME/Library/Application Support/com.mitchellh.ghostty/shaders.conf"
SHADER="$HOME/Development/dotfiles/shaders/${SHADER_NAME}.glsl"

if [ ! -f "$SHADER" ]; then
    echo "Shader not found: $SHADER" >&2
    exit 1
fi

if [ -e "$CONF_PATH" ]; then
    rm "$CONF_PATH"
else
    cat > "$CONF_PATH" <<EOF
custom-shader = $SHADER
custom-shader-animation = true
EOF
fi

pkill -USR2 ghostty
