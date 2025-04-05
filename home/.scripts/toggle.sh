#!/bin/sh

# Toggle dark and light themes for nvim
NVIM_CONF="$HOME/.config/nvim/lua/config/03_background.lua"

switch_vim_theme() {
    tmux list-panes -a -F '#{pane_id} #{pane_current_command}' |
    grep vim | # this captures vim and nvim
    cut -d ' ' -f 1 |
    xargs -I PANE tmux send-keys -t PANE ":set background=$1" ENTER
}

if [ "$1" = "dark" ]; then
    sed -i 's/light/dark/' "$NVIM_CONF"
    switch_vim_theme "dark"

else
    sed -i 's/dark/light/' "$NVIM_CONF"
    switch_vim_theme "light"

fi
