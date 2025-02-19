return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = {
        sign = true,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = true,
        icons = { "󰎥  ", "󰎨  ", "󰎫  ", "󰎲  ", "󰎯  ", "󰎴  " },
        position = "inline",
      },
      bullet = {
        right_pad = 1,
      },
      checkbox = {
        enabled = true,
        right_pad = 0,
        custom = {
          question = { raw = "[?]", rendered = "", highlight = "RenderMarkdownError" },
          ongoing = { raw = "[>]", rendered = "", highlight = "RenderMarkdownSuccess" },
          canceled = { raw = "[~]", rendered = "󰗨", highlight = "ObsidianTilde" },
          important = { raw = "[!]", rendered = "", highlight = "RenderMarkdownWarn" },
          favorite = { raw = "[^]", rendered = "", highlight = "RenderMarkdownMath" },
        },
      },
    },
  },
  {
    "HakonHarnes/img-clip.nvim",
    ft = "markdown",
    opts = {
      -- add options here
      -- or leave it empty to use the default settings
    },
    keys = {
      -- suggested keymap
      { "<leader>mp", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
}
