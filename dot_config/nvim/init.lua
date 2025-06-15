-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.env.VSCODE then
  vim.g.vscode = true
end

if vim.loader then
  vim.loader.enable()
end

_G.dd = function(...)
  require("snacks.debug").inspect(...)
end
_G.bt = function(...)
  require("snacks.debug").backtrace()
end
_G.p = function(...)
  require("snacks.debug").profile(...)
end
vim.print = _G.dd

if vim.env.PROF then
  if vim.fn.has("win32") == 1 then
    vim.opt.rtp:append("~/.local/share/nvim-data/lazy/snacks.nvim/")
  else
    vim.opt.rtp:append("~/.local/share/nvim/lazy/snacks.nvim/")
  end

  require("snacks.profiler").startup({
    startup = {
      -- event = "UIEnter",
      -- event = "VeryLazy",
    },
    -- runtime = "~/projects/neovim/runtime",
  })
end

pcall(require, "config.env")

require("config.lazy")
require("utils.config")
