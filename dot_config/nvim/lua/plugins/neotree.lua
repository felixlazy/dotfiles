return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    { "akinsho/toggleterm.nvim", event = "VeryLazy" },
  },
  opts = {
    event_handlers = {
      {
        event = "file_opened",
        handler = function(_)
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },
}
