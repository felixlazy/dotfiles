return {
  {
    "3rd/image.nvim",
    cond = vim.g.neovide == nil,
    ft = "markdown",
    opts = function()
      if os.getenv("TERM") == "xterm-256color" then
        return { backend = "wezterm" }
      end
    end,
  },
}
