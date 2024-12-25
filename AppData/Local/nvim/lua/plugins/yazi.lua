return {
  {
    "mikavilpas/yazi.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        -- 👇 choose your own keymapping
        "<leader>ya",
        function()
          require("yazi").yazi()
        end,
        { desc = "Open the file manager" },
      },
      {
        -- Open in the current working directory
        "<leader>cw",
        function()
          require("yazi").yazi(nil, vim.fn.getcwd())
        end,
        desc = "Open the file manager in nvim's working directory",
      },
    },
    ---@type YaziConfig
    opts = {
      floating_window_scaling_factor = 0.8,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
}
