vim.keymap.set("n", "gx", function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  local target = nil

  -- 从当前行中提取链接
  for match in line:gmatch("%[.-%]%b()") do
    local s, e = line:find(match, 1, true)
    if s and e and s <= col and e >= col then
      target = match:sub(match:find("%b()") + 1, -2) -- 获取 () 内的链接
      break
    end
  end

  -- 如果没有在光标下找到链接，尝试从整个行中提取链接
  if not target then
    -- 提取第一个出现的链接
    for match in line:gmatch("%[.-%]%b()") do
      target = match:sub(match:find("%b()") + 1, -2) -- 获取 () 内的链接
      break
    end
  end
  -- fallback: 光标下的文件路径
  if not target or target == "" then
    target = vim.fn.expand("<cfile>")
  end

  -- 展开 ~ 等路径
  target = vim.fn.expand(target)

  local function run(cmd)
    vim.fn.jobstart(cmd, { detach = true })
  end

  -- 处理视频文件：mp4, mkv, webm，支持 Bilibili 和 YouTube 链接
  if
    target:match("%.mp4$")
    or target:match("%.mkv$")
    or target:match("%.webm$")
    or target:match("bilibili%.com")
    or target:match("youtube%.com")
    or target:match("youtu%.be")
  then
    run({ "mpv", target })

  -- 处理 PDF 文件
  elseif target:match("%.pdf$") and vim.fn.filereadable(target) == 1 then
    if vim.fn.has("mac") == 1 then
      -- Mac 系统，使用默认 PDF 阅读器
      run({ "open", target })
    elseif vim.fn.has("unix") == 1 then
      -- Linux 系统，使用默认 PDF 阅读器（例如 Evince 或 Okular）
      run({ "xdg-open", target })
    elseif vim.fn.has("win32") == 1 then
      -- Windows 系统，使用默认 PDF 阅读器
      run({ "cmd.exe", "/C", "start", "", target })
    end

  -- 处理图片文件：jpg, png, gif 等
  elseif target:match("%.jpg$") or target:match("%.png$") or target:match("%.gif$") or target:match("%.jpeg$") then
    if vim.fn.has("mac") == 1 then
      -- Mac 系统，使用默认图片查看器（Preview）
      run({ "open", target })
    elseif vim.fn.has("unix") == 1 then
      -- Linux 系统，使用默认图片查看器（如 eog、shotwell）
      run({ "xdg-open", target })
    elseif vim.fn.has("win32") == 1 then
      -- Windows 系统，使用默认图片查看器（Photos）
      run({ "cmd.exe", "/C", "start", "", target })
    end

  -- 处理本地文件（直接在 Neovim 中打开）
  elseif vim.fn.filereadable(target) == 1 then
    vim.cmd("edit " .. vim.fn.fnameescape(target))

  -- 处理网页链接，使用浏览器打开
  elseif target:match("^https?://") then
    if vim.fn.has("mac") == 1 then
      -- Mac 系统，使用 Safari 打开网页
      run({ "open", target })
    elseif vim.fn.has("unix") == 1 then
      -- Linux 系统，使用默认浏览器打开网页
      run({ "xdg-open", target })
    elseif vim.fn.has("win32") == 1 then
      -- Windows 系统，使用 Edge 打开网页
      run({ "cmd.exe", "/C", "start", "msedge", target })
    end
  else
    vim.notify("无法识别的链接或路径: " .. target, vim.log.levels.WARN)
  end
end, { desc = "Smart gx: mpv, pdf, images, browser, nvim edit" })
