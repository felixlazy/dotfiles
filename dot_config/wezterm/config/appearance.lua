local wezterm = require("wezterm")
local gpu_adapters = require("utils.gpu_adapter")
local colors = require("colors.custom")

return {
	animation_fps = 60,
	max_fps = 60,
	front_end = "OpenGL",
	-- front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",
	webgpu_preferred_adapter = gpu_adapters:pick(),

	-- color scheme
	-- colors = colors,

	color_scheme = "tokyonight_moon",
	-- background
	-- background = {
	--    {
	--       source = { File = wezterm.GLOBAL.background },
	--    },
	--    {
	--       source = { Color = colors.background },
	--       height = '100%',
	--       width = '100%',
	--       opacity = 0.94,
	--    },
	-- },

	-- tab bar
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = false,
	use_fancy_tab_bar = false,
	tab_max_width = 25,
	show_tab_index_in_tab_bar = false,
	switch_to_last_active_tab_when_closing_tab = true,

	-- window
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	window_close_confirmation = "NeverPrompt",
	window_frame = {
		active_titlebar_bg = "#090909",
		-- font = fonts.font,
		-- font_size = fonts.font_size,
	},
	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.65,
	},
	--config.window_decorations = "NONE"
	window_decorations = "RESIZE",
	-------------------- 窗口居中 --------------------
	wezterm.on("gui-startup", function(cmd)
		local padSize = 60
		local screen = wezterm.gui.screens().active
		local tab, pane, window = wezterm.mux.spawn_window(cmd or {
			workspace = "main",
		})
		window:gui_window():set_position(padSize, padSize)
		window:gui_window():set_inner_size(screen.width - (padSize * 2), screen.height - (padSize * 2) - 100)
	end),
}
