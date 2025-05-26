local function copy_file(src, dst, opts)
  opts = opts or {}
  if vim.fn.filereadable(src) == 0 then
    vim.notify("Source file does not exist: " .. src, vim.log.levels.ERROR)
    return false
  end

  -- Skip if target already exists and skip_if_exists is true
  if opts.skip_if_exists and vim.fn.filereadable(dst) == 1 then
    vim.notify(dst .. " already exists, skipping copy", vim.log.levels.WARN)
    return false
  end

  local ok, err = pcall(function()
    vim.fn.writefile(vim.fn.readfile(src), dst)
  end)

  if ok then
    vim.notify("Copied to " .. dst .. " successfully", vim.log.levels.INFO)
    return true
  else
    vim.notify("Copy failed: " .. err, vim.log.levels.ERROR)
    return false
  end
end

local function ensure_dir_exists(path)
  if vim.fn.isdirectory(path) == 0 then
    local ok, err = pcall(vim.fn.mkdir, path, "p")
    if not ok then
      vim.notify("Failed to create directory: " .. err, vim.log.levels.ERROR)
      return false
    end
  end
  return true
end
function copy_nvim_lua()
  -- Copy .nvim.template.lua -> .nvim.lua (skip if exists)
  local src = vim.fn.expand("~/.config/template/nvim/.nvim.template.lua")
  local dst = LazyVim.root() .. "/.nvim.lua"

  copy_file(src, dst, { skip_if_exists = true })
end
if vim.fn.has("win32") == 1 then
  vim.keymap.set("n", "<leader>oc", function()
    local root = LazyVim.root()

    -- Copy overseer.template.lua -> .nvim/overseer_task.lua
    local src1 = vim.fn.expand("~/.config/template/nvim/overseer.template.lua")
    local dst_dir = root .. "/.nvim"
    local dst1 = dst_dir .. "/overseer_task.lua"

    if ensure_dir_exists(dst_dir) then
      copy_file(src1, dst1)
    end
    copy_nvim_lua()
  end, { desc = "Copy overseer to .nvim/ and template to .nvim.lua in project root" })
end
