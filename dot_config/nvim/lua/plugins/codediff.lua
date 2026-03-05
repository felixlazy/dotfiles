return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  keys = {
    { "<leader>dv", "<cmd>CodeDiff<cr>", desc = "CodeDiff" },
    { "<leader>dvf", "<cmd>CodeDiff history %<cr>", desc = "CodeDiff history file" },
  },
  opts = {
    keymaps = {
      view = {
        next_hunk = "]h",
        prev_hunk = "[h",
      },
    },
  },
}
