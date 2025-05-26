local root = LazyVim.root() -- 或者 LazyVim.root()，取决你用哪个

local nvim_path = root .. "/.nvim/?.lua"
local nvim_init_path = root .. "/.nvim/?/init.lua"

if not string.find(package.path, nvim_path, 1, true) then
	package.path = nvim_path .. ";" .. package.path
end
if not string.find(package.path, nvim_init_path, 1, true) then
	package.path = nvim_init_path .. ";" .. package.path
end
