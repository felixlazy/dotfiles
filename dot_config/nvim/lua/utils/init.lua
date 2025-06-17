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
