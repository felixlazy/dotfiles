th.git = th.git or {}
th.git.added = ui.Style():fg("#a6e3a1")
th.git.untracked = ui.Style():fg("gray")
th.git.modified = ui.Style():fg("#f9e2af")
th.git.added_sign = ""
th.git.untracked_sign = ""
th.git.modified_sign = ""
th.git.deleted_sign = ""
require("git"):setup()
require("starship"):setup()
require("yaziline"):setup({
	select_symbol = "",
	yank_symbol = "󰆐",
	filename_max_length = 24, -- trim when filename > 24
	filename_trim_length = 6, -- trim 6 chars from both ends
})
require("projects"):setup({
	save = {
		method = "yazi", -- yazi | lua
		lua_save_path = "", -- comment out to get the default value
		-- windows: "%APPDATA%/yazi/state/projects.json"
		-- unix: "~/.local/state/yazi/projects.json"
	},
	last = {
		update_after_save = true,
		update_after_load = true,
		load_after_start = false,
	},
	merge = {
		quit_after_merge = false,
	},
	notify = {
		enable = true,
		title = "Projects",
		timeout = 3,
		level = "info",
	},
})
