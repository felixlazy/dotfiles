local platform = require("utils.platform")()

local options = {
	launch_menu = {},
}

if platform.is_win then
	options.default_prog = { "pwsh" }
	options.launch_menu = {
		{ label = "PowerShell Core", args = { "pwsh" } },
		{ label = "neovide", args = { "neovide", "--frame", "none" } },
		{ label = "Command Prompt", args = { "cmd" } },
		{ label = "btm", args = { "btm" } },
		{ label = "Git Bash", args = { "bash" } },
		{ label = "lazygit", args = { "lazygit" } },
	}
elseif platform.is_mac then
	options.default_prog = { "zsh" }
	options.launch_menu = {
		{ label = "Bash", args = { "bash" } },
		{ label = "Fish", args = { "/opt/homebrew/bin/fish" } },
		{ label = "Nushell", args = { "/opt/homebrew/bin/nu" } },
		{ label = "Zsh", args = { "zsh" } },
	}
elseif platform.is_linux then
	options.default_prog = { "fish" }
	options.launch_menu = {
		{ label = "Bash", args = { "bash" } },
		{ label = "Fish", args = { "fish" } },
		{ label = "Zsh", args = { "zsh" } },
	}
end

return options
