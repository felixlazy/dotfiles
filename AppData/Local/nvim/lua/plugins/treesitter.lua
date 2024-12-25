return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c",
        "cpp",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "powershell",
      },
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "LazyFile",
    -- Bracket pair rainbow colorize
  },
}
