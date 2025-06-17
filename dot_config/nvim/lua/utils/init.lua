local M = {}
vim.cmd("hi Visual gui=reverse")
vim.cmd("highlight CursorLine gui=NONE guibg=bg")
-- vim.cmd("highlight Cursor gui=NONE guifg=bg guibg=#ffb6c1")
-- add additional keyword chars
require("utils.mpv")
require("utils.folding")
require("utils.gx")
if vim.fn.has("win32") == 1 then
  local template = require("utils.template")
  local root = LazyVim.root()
  vim.api.nvim_create_user_command("CopyOverseerMdk", function()
    local src = vim.fn.expand("~/.config/template/nvim/overseer_mdk.template.lua")
    local dst_dir = root .. "/.nvim"
    local dst = dst_dir .. "/overseer_mdk.lua"

    if template.ensure_dir_exists(dst_dir) then
      template.copy_file(src, dst)
    end

    template.copy_nvim_lua()
  end, { desc = "Copy overseer to .nvim/ and template to .nvim.lua in project root" })
end

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

function M.cowboy()
  ---@type table?
  local ok = true
  for _, key in ipairs({ "h", "j", "k", "l", "+", "-" }) do
    local count = 0
    local timer = assert(vim.uv.new_timer())
    local map = key
    vim.keymap.set("n", key, function()
      if vim.v.count > 0 then
        count = 0
      end
      if count >= 10 and vim.bo.buftype ~= "nofile" then
        ok = pcall(vim.notify, "Hold it Cowboy!", vim.log.levels.WARN, {
          icon = "🤠",
          id = "cowboy",
          keep = function()
            return count >= 10
          end,
        })
        if not ok then
          return map
        end
      else
        count = count + 1
        timer:start(2000, 0, function()
          count = 0
        end)
        return map
      end
    end, { expr = true, silent = true })
  end
end

return M
