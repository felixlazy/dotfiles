local M = {}
vim.cmd("hi Visual gui=reverse")
vim.cmd("highlight CursorLine gui=NONE guibg=bg")
-- vim.cmd("highlight Cursor gui=NONE guifg=bg guibg=#ffb6c1")
-- add additional keyword chars
require("utils.folding")
require("utils.gx")

-- 获取系统类型（Windows / Linux / Darwin）
local sysname = vim.loop.os_uname().sysname

function M.open_path(path)
  path = vim.fn.shellescape(path)
  if sysname == "Windows_NT" then
    vim.cmd("!explorer " .. path)
  elseif sysname == "Darwin" then
    vim.cmd("!open " .. path)
  else
    vim.cmd("!xdg-open " .. path)
  end
end

function M.open_with_vscode(path)
  path = vim.fn.shellescape(path)
  vim.cmd("!code " .. path)
end

function M.get_buf_dir()
  local path = vim.api.nvim_buf_get_name(0)
  return path ~= "" and vim.fn.fnamemodify(path, ":h") or vim.fn.getcwd()
end

return M
