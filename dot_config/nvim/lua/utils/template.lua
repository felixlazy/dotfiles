local M = {}

-- 确保目录存在
function M.ensure_dir_exists(path)
  if vim.fn.isdirectory(path) == 0 then
    local ok, err = pcall(vim.fn.mkdir, path, "p")
    if not ok then
      vim.notify("Failed to create directory: " .. err, vim.log.levels.ERROR)
      return false
    end
  end
  return true
end

function M.copy_file(src, dst, opts)
  opts = opts or {}

  if vim.fn.filereadable(src) == 0 then
    vim.notify("Source file does not exist: " .. vim.fn.fnamemodify(src, ":t"), vim.log.levels.ERROR)
    return false
  end

  if opts.skip_if_exists and vim.fn.filereadable(dst) == 1 then
    vim.notify(vim.fn.fnamemodify(dst, ":t") .. " already exists, skipping copy", vim.log.levels.WARN)
    return false
  end

  local ok, err = pcall(function()
    vim.fn.writefile(vim.fn.readfile(src), dst)
  end)

  if ok then
    vim.notify("Copied " .. vim.fn.fnamemodify(dst, ":t") .. " successfully", vim.log.levels.INFO)
    return true
  else
    vim.notify("Copy failed: " .. err, vim.log.levels.ERROR)
    return false
  end
end

-- 拷贝 ~/.config/template/nvim/.nvim.template.lua 到项目根目录
function M.copy_nvim_lua()
  local src = vim.fn.expand("~/.config/template/nvim/.nvim.template.lua")
  local dst = require("lazyvim.util").root() .. "/.nvim.lua"
  return M.copy_file(src, dst, { skip_if_exists = true })
end

return M
