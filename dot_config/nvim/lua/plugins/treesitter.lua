vim.filetype.add({
  extension = {
    conf = "kconfig",
  },
  filename = {
    ["*.conf"] = "kconfig",
    [".config"] = "kconfig",
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
