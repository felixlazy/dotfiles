-- overseer mdk 任务
local overseer = require("overseer")
local root = LazyVim.root

local function find_uvprojx()
	local files = vim.fn.glob(root() .. "/**/*.uvprojx", false, true)
	return files[1]
end

local function make_log_name(uvprojx)
	return vim.fn.fnamemodify(uvprojx, ":t:r") .. ".log"
end

local templates = {
	{
		name = "mdk build",
		builder = function()
			local uvprojx = find_uvprojx()
			local log = make_log_name(uvprojx)
			return {
				cmd = { "UV4" },
				args = { "-b", "-j8", uvprojx, "-o", log },
				cwd = root(),
				name = "mdk build",
				components = {
					{
						"run_after",
						task_names = { "mdk build log" },
						detach = true,
						statuses = { "SUCCESS", "FAILURE" },
					},
					{ "on_complete_dispose", timeout = 1 },
					"default",
				},
				default_component_params = {
					errorformat = "%f:%l:%m,%-G[Process exited%.%#,]",
				},
			}
		end,
		desc = "Compile the firmware using MDK (no flashing)",
		params = {},
		priority = 2,
	},
	{
		name = "mdk build and flash",
		builder = function()
			local uvprojx = find_uvprojx()
			local log = make_log_name(uvprojx)
			return {
				cmd = { "UV4" },
				args = { "-b", "-j8", uvprojx, "-o", log },
				cwd = root(),
				name = "mdk build downlocal",
				components = {
					{
						"run_after",
						task_names = { "mdk build log", "mdk flash" },
						detach = true,
						statuses = { "SUCCESS", "FAILURE" },
					},
					{ "on_complete_dispose", timeout = 1 },
					"default",
				},
			}
		end,
		desc = "Compile and flash firmware",
		params = {},
		priority = 0,
	},
	{
		name = "mdk build log",
		builder = function()
			local files = vim.fn.glob(root() .. "/**/*.log", false, true)
			local log_pwd = (#files > 0) and files[1] or nil
			if not log_pwd then
				return {
					cmd = "echo",
					args = { "No .log file found" },
					cwd = root(),
				}
			end
			return {
				cmd = "sh",
				args = {
					"-c",
					string.format("sed -i 's|^..[\\\\/]||' '%s' && cat '%s'", log_pwd, log_pwd),
				},
				cwd = root(),
				components = {
					{ "on_complete_notify", statuses = {} },
					{ "on_output_quickfix", open_on_match = true },
					{ "on_complete_dispose", timeout = 1 },
					"default",
				},
				default_component_params = {
					errorformat = "%-GBuild Time Elapsed:%.%#,%f(%l):%m,%f(%l): %t%*[^:]: %m,",
				},
			}
		end,
		desc = "Parse and show log in quickfix",
		params = {},
		priority = 51,
	},
	{
		name = "mdk flash",
		builder = function()
			local uvprojx = find_uvprojx()
			local log = make_log_name(uvprojx)
			return {
				cmd = { "UV4" },
				args = { "-f", "-j0", uvprojx, "-o", log },
				cwd = root(),
				name = "mdk flash",
				components = {
					{ "unique" },
					{ "on_complete_dispose", statuses = { "SUCCESS", "FAILURE" }, timeout = 1 },
					"default",
				},
			}
		end,
		desc = "Flash firmware",
		params = {},
		priority = 1,
	},
	{
		name = "generate compile_commands.json",
		builder = function()
			return {
				cmd = { "compiledb" },
				args = { "-n", "make" },
				cwd = root(),
			}
		end,
		desc = "generate compile_commands.json",
		params = {},
		priority = 50,
	},
	{
		name = "mdk rebuild",
		builder = function()
			local uvprojx = find_uvprojx()
			local log = make_log_name(uvprojx)
			return {
				cmd = { "UV4" },
				args = { "-r", "-j0", uvprojx, "-o", log },
				cwd = root(),
				name = "mdk rebuild",
				components = {
					{
						"run_after",
						task_names = { "mdk build log" },
						detach = true,
						statuses = { "SUCCESS", "FAILURE" },
					},
					{ "on_complete_dispose", timeout = 1 },
					"default",
				},
			}
		end,
		desc = "Rebuild firmware from scratch",
		params = {},
		priority = 2,
	},
	{
		name = "serial",
		builder = function()
			return {
				cmd = { "lazyserial" },
				args = { "serial", "COM3", "-b", "115200" },
				cwd = root(),
				name = "serial",
			}
		end,
		desc = "serial",
		params = {},
	},
}

-- 注册所有模板
for _, template in ipairs(templates) do
	overseer.register_template(template)
end
