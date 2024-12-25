return {
  "nanotee/zoxide.vim",
  cmd = { "Z", "Zi" },
  keys = {
    { "<leader>fz", ":Zi<CR>", desc = "[F]ZF [Z]oxide CD" },
  },
  init = function()
    vim.g.zoxide_use_select = 1
  end,
}
