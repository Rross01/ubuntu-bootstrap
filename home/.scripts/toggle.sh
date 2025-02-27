#!/bin/sh

# Toggle dark and light themes for tmux, alacritty, and nvim
LIGHTTHEME="gruvbox_light"
DARKTHEME="gruvbox_dark"

NVIM_CONF="$HOME/.config/nvim/lua/config/03_background.lua"
ALACRITTY_CONF="$HOME/.config/alacritty/alacritty.toml"
TMUX_CONF="$HOME/.config/tmux/tmux.conf"

switch_vim_theme() {
    theme_for_vim_panes="$1"
    tmux list-panes -a -F '#{pane_id} #{pane_current_command}' |
    grep vim | # this captures vim and nvim
    cut -d ' ' -f 1 |
    xargs -I PANE tmux send-keys -t PANE ":set background=$theme_for_vim_panes" ENTER
}

if [ "$1" = "dark" ]; then
    sed -i "s/${LIGHTTHEME}/${DARKTHEME}/" "$ALACRITTY_CONF" "$TMUX_CONF"
    sed -i 's/light/dark/' "$NVIM_CONF"
    switch_vim_theme "dark"
else
    sed -i "s/${DARKTHEME}/${LIGHTTHEME}/" "$ALACRITTY_CONF" "$TMUX_CONF"
    sed -i 's/dark/light/' "$NVIM_CONF"
    switch_vim_theme "light"
fi

# I don't know why, but tmux applies only after second run
tmux source-file "$TMUX_CONF"
tmux source-file "$TMUX_CONF"
