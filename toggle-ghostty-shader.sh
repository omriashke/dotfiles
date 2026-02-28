#!/bin/bash
CONF_PATH="$HOME/Library/Application Support/com.mitchellh.ghostty/shaders.conf"
SHADER="$HOME/Development/dotfiles/shaders/starfield-colors.glsl"

if [ -e "$CONF_PATH" ]; then
    rm "$CONF_PATH"
else
    cat > "$CONF_PATH" <<EOF
custom-shader = $SHADER
custom-shader-animation = true
EOF
fi

pkill -USR2 ghostty
