local wezterm = require("wezterm") --[[@as Wezterm]]
local config = wezterm.config_builder()
wezterm.log_info("reloading")

require("tabs").setup(config)
require("mouse").setup(config)
require("links").setup(config)
require("keys").setup(config)

-- config.front_end = "WebGpu"
-- config.front_end = "OpenGL" -- current work-around for https://github.com/wez/wezterm/issues/4825
config.enable_wayland = true
config.webgpu_power_preference = "HighPerformance"
-- config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- Colorscheme
config.color_scheme = "tokyonight_moon"
config.colors = {
	indexed = { [241] = "#65bcff" },
}

config.underline_position = -6

if wezterm.target_triple:find("windows") then
	config.default_prog = { "pwsh" }
else
	config.term = "wezterm"
	config.window_decorations = "NONE"
end

config.window_decorations = "RESIZE"
wezterm.on("gui-startup", function(cmd)
	local padSize = 60
	local screen = wezterm.gui.screens().active
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {
		workspace = "main",
	})
	window:gui_window():set_position(padSize, padSize)
	window:gui_window():set_inner_size(screen.width - (padSize * 2), screen.height - (padSize * 2) - 100)
end)
-- Fonts
config.font_size = 14
config.font = wezterm.font({ family = "Maple Mono NF CN" })
config.bold_brightens_ansi_colors = true
config.font_rules = {
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font({ family = "Maple Mono NF CN", weight = "Bold", style = "Italic" }),
	},
	{
		italic = true,
		intensity = "Half",
		font = wezterm.font({ family = "Maple Mono NF CN", weight = "DemiBold", style = "Italic" }),
	},
	{
		italic = true,
		intensity = "Normal",
		font = wezterm.font({ family = "Maple Mono NF CN", style = "Italic" }),
	},
}

-- Cursor
-- config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = true
config.window_padding = { left = 5, right = 0, top = 0, bottom = 0 }
-- window_background_opacity = 0.9,
-- cell_width = 0.9,
config.scrollback_lines = 10000

-- Command Palette
config.command_palette_font_size = 13
config.command_palette_bg_color = "#394b70"
config.command_palette_fg_color = "#828bb8"

return config
