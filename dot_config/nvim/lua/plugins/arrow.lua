return {
  {
    "otavioschwanck/arrow.nvim",
    dependencies = {
      { "echasnovski/mini.icons" },
    },
    keys = {
      ";",
      "<space>m",
    },
    opts = {
      show_icons = true,
      leader_key = ";", -- Recommended to be a single key
      buffer_leader_key = "<space>m", -- Per Buffer Mappings
    },
  },
}
