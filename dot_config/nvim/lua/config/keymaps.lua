-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- This file is automatically loaded by lazyvim.config.initlocal
local Util = require("lazyvim.util")
local map = Util.safe_keymap_set
map("n", "gb", "<Cmd>BufferLinePick<CR>", { noremap = true, silent = true })
map("i", "jk", "<esc>")

-- windown
map("n", "qf", "<C-w>o")
map("n", "<up>", ":res -5<CR>", { noremap = true, silent = true })
map("n", "<down>", ":res +5<CR>", { noremap = true, silent = true })
map("n", "<left>", ":vertical resize+5<CR>", { noremap = true, silent = true })
map("n", "<right>", ":vertical resize-5<CR>", { noremap = true, silent = true })
map("t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

local Util = require("utils") -- 改成你的路径

map("n", "<leader>ee", function()
  Util.open_path(Util.get_buf_dir())
end, { desc = "Open folder of current file" })

map("n", "<leader>ed", function()
  Util.open_path(LazyVim.root()) -- 你已有的项目根目录函数
end, { desc = "Open project root folder" })

map("n", "<leader>co", function()
  Util.open_with_vscode(vim.api.nvim_buf_get_name(0))
end, { desc = "Open current file with VSCode" })

map("n", "<leader>cow", function()
  Util.open_with_vscode(LazyVim.root())
end, { desc = "Open project in VSCode" })
Util.cowboy()
