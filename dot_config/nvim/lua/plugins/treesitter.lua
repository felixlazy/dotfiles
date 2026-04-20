vim.filetype.add({
  -- 只有当文件名明确为 Kconfig 时才关联
  filename = {
    ["Kconfig"] = "kconfig",
    [".config"] = "kconfig",
  },
  -- 只有在特定的路径模式下才将 .conf 视为 kconfig
  -- 或者你可以保持手动设置
  pattern = {
    ["prj.*%.conf"] = "kconfig",
    [".*/zephyr/.*%.conf"] = "kconfig",
  },
})
return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "LazyFile",
    -- Bracket pair rainbow colorize
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "kconfig", "devicetree", "powershell" } },
  },
}
