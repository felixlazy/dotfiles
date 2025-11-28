-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "c", "cpp" },
  callback = function()
    vim.b.autoformat = false
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.spell = false
    vim.opt.wrap = false
  end,
})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  callback = function(ev)
    vim.diagnostic.config({ virtual_text = false })
  end,
})
-- 自动化命令：在进入可视模式时关闭相对行号
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*:[vV\x16]*", -- 进入可视模式
  callback = function()
    vim.api.nvim_command(" lua Snacks.indent.disable()")
  end,
})

-- 自动化命令：在离开可视模式时启用相对行号
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "[vV\x16]*:*", -- 离开可视模式
  callback = function()
    vim.api.nvim_command(" lua Snacks.indent.enable()")
  end,
})
-- win模式下自动切换输入法

if vim.fn.has("win32") == 1 then
  require("utils.win_ime_toggle")
end

-- rust
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    local opts = { noremap = true, silent = true, buffer = true }
    vim.keymap.set("n", "<leader>em", "<cmd>RustLsp expandMacro<CR>", opts)
  end,
})

require("utils.toggle_number")
