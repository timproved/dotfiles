local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Existing configurations
config.color_scheme = "zenwritten_dark"
config.default_prog = { "powershell.exe" }

-- New configurations
config.leader = { key = "s", mods = "CTRL" }

config.keys = {
	-- Vertical split with Leader + "
	{
		key = '"',
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- Horizontal split with Leader + %
	{
		key = "%",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	-- Navigate tabs with Leader + h/j/k/l 
    {key="h", mods="LEADER", action=wezterm.action.ActivatePaneDirection("Left")},
    {key="l", mods="LEADER", action=wezterm.action.ActivatePaneDirection("Right")},
    {key="j", mods="LEADER", action=wezterm.action.ActivatePaneDirection("Down")},
    {key="k", mods="LEADER", action=wezterm.action.ActivatePaneDirection("Up")},

	-- Resize splits with Leader + Arrow keys
	{ key = "LeftArrow", mods = "CTRL", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "RightArrow", mods = "CTRL", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
	{ key = "UpArrow", mods = "CTRL", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
	{ key = "DownArrow", mods = "CTRL", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },

	-- Switch to specific tabs with Leader + 1-9
	{ key = "1", mods = "LEADER", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "LEADER", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "LEADER", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "LEADER", action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "LEADER", action = wezterm.action.ActivateTab(4) },
	{ key = "6", mods = "LEADER", action = wezterm.action.ActivateTab(5) },
	{ key = "7", mods = "LEADER", action = wezterm.action.ActivateTab(6) },
	{ key = "8", mods = "LEADER", action = wezterm.action.ActivateTab(7) },
	{ key = "9", mods = "LEADER", action = wezterm.action.ActivateTab(8) },

	--  -- Create a new tab with Leader + c
	{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },

	-- Close the current tab with Leader + x
	{ key = "d", mods = "LEADER", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
}

return config
