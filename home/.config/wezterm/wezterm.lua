-- SETUP
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action
config.color_scheme = "Monokai (terminal.sexy)"
config.font = wezterm.font({
	family = "JetBrains Mono",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.font_size = 11.5
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_close_confirmation = "NeverPrompt"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.colors = {
	tab_bar = {
		background = "#000000",
		active_tab = { bg_color = "#2b2042", fg_color = "#c0c0c0" },
		inactive_tab = { bg_color = "#1b1032", fg_color = "#808080" },
		inactive_tab_hover = { bg_color = "#3b3052", fg_color = "#909090" },
		new_tab = { bg_color = "#1b1032", fg_color = "#808080" },
		new_tab_hover = { bg_color = "#3b3052", fg_color = "#909090" },
	},
}

-- SMART-SPLIT NVIM
local direction_keys = { h = "Left", j = "Down", k = "Up", l = "Right" }
local function split_nav(key, resize_or_move)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if pane:get_user_vars().IS_NVIM == "true" then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

-- print the workspace name at the right
wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace())
end)

local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

wezterm.on("update-status", function(window, pane)
	local padding = { left = 8, right = 8, top = 8, bottom = 8 }
	local overrides = window:get_config_overrides() or {}
	if string.find(pane:get_title(), "^n-vi-m-.*") then
		overrides.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
	else
		overrides.window_padding = padding
	end
	window:set_config_overrides(overrides)
end)

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Workspace switcher
	{ key = "f", mods = "CTRL", action = workspace_switcher.switch_workspace() },
	-- Tab navigation
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "l", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	-- move between split panes
	split_nav("h", "move"),
	split_nav("j", "move"),
	split_nav("k", "move"),
	split_nav("l", "move"),
	-- resize panes
	split_nav("h", "resize"),
	split_nav("j", "resize"),
	split_nav("k", "resize"),
	split_nav("l", "resize"),
	-- splitting
	{ mods = "LEADER", key = "=", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "-", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "z", action = act.TogglePaneZoomState },
	-- rotate panes
	{ mods = "LEADER", key = "Space", action = act.RotatePanes("Clockwise") },
	-- swap active pane with selected
	{ mods = "LEADER", key = "0", action = act.PaneSelect({ mode = "SwapWithActive" }) },
	-- Activate copy mode or vim mode
	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
	-- Tabs navigation
	{ key = "1", mods = "LEADER", action = act({ ActivateTab = 0 }) },
	{ key = "2", mods = "LEADER", action = act({ ActivateTab = 1 }) },
	{ key = "3", mods = "LEADER", action = act({ ActivateTab = 2 }) },
	{ key = "4", mods = "LEADER", action = act({ ActivateTab = 3 }) },
	{ key = "5", mods = "LEADER", action = act({ ActivateTab = 4 }) },
	{ key = "6", mods = "LEADER", action = act({ ActivateTab = 5 }) },
	{ key = "7", mods = "LEADER", action = act({ ActivateTab = 6 }) },
	{ key = "8", mods = "LEADER", action = act({ ActivateTab = 7 }) },
	{ key = "9", mods = "LEADER", action = act({ ActivateTab = 8 }) },
	{ key = "x", mods = "LEADER", action = act({ CloseCurrentPane = { confirm = true } }) },
	-- Workaround for screen's keybind
	{ key = "a", mods = "LEADER", action = act.SendKey({ key = "a", mods = "CTRL" }) },
}
return config