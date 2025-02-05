-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "c", "cpp", "toml" },
  callback = function()
    vim.b.autoformat = false
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.spell = false
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
