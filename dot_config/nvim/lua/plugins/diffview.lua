return {
  "sindrets/diffview.nvim",
  keys = {
    { "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "DiffviewOpen" },
    {
      "<leader>dvf",
      "<cmd>DiffviewFileHistory %<cr> ",
      desc = "DiffviewFileHistory",
    },
    { "<leader>dvs", "<cmd>DiffviewOpen --untracked-file<cr>", desc = "DiffviewOpen staged" },
  },
}
