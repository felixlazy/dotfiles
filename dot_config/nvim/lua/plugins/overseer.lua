return {
  "stevearc/overseer.nvim",
  keys = function()
    return {
      { "<leader>ow", "<cmd>OverseerToggle<cr>", desc = "Task list" },
      { "<leader>oo", "<cmd>OverseerRun<cr>", desc = "Run task" },
      { "<leader>ob", "<cmd>OverseerShell<cr>", desc = "Task builder" },
      { "<leader>ot", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
      { "<leader>oc", "<cmd>OverseerClose<cr>", desc = "Clear cache" },
    }
  end,
  cmd = function()
    return {
      "OverseerOpen",
      "OverseerClose",
      "OverseerToggle",
      "OverseerShell",
      "OverseerRun",
      "OverseerTaskAction",
    }
  end,
  opts = {
    output = {
      -- Use a terminal buffer to display output. If false, a normal buffer is used
      use_terminal = false,
      -- If true, don't clear the buffer when a task restarts
      preserve_output = false,
    },
  },
}
