-- SETUP
local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Gruvbox Dark (Gogh)"
config.font_size = 11.5
config.font = wezterm.font({
	family = "JetBrains Mono",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
-- config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

return config
