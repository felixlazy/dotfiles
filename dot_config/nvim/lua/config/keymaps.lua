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
-- 解决 visual 选中粘贴替换只能粘贴一次的问题
vim.keymap.set("x", "p", "P")

local function getPwd()
  local str = vim.api.nvim_buf_get_name(0)
  local index
  index, _ = string.find(vim.api.nvim_buf_get_name(0), "[^\\]*$")
  local new_str = string.sub(str, 1, index - 2)
  return new_str
end
map("n", "<leader>ee", function()
  local command = "!explorer " .. getPwd()
  vim.api.nvim_command(command)
end, { noremap = true, silent = true })

map("n", "<leader>ed", function()
  local root = "!explorer " .. Util.root()
  vim.api.nvim_command(root)
end, { noremap = true, silent = true })

map("n", "<leader>et", function()
  Util.terminal(nil, { cwd = getPwd() })
end, { desc = "Terminal (file dir)" })

map("n", "<leader>co", function()
  local command = "!code " .. vim.api.nvim_buf_get_name(0)
  vim.api.nvim_command(command)
end, { desc = "Terminal (file dir)" })

map("n", "<leader>cow", function()
  local command = "!code " .. LazyVim.root()
  vim.api.nvim_command(command)
end, { desc = "Terminal (file dir)" })
