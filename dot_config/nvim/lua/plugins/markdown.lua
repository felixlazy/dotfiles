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
      default = {
        dir_path = "image", ---@type string | fun(): string
      },
      filetypes = {
        markdown = {
          template = "![$FILE_NAME_NO_EXT]($FILE_PATH)",
        },
      },
      -- add options here
      -- or leave it empty to use the default settings
    },
    keys = {
      -- suggested keymap
      { "<leader>pm", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
}
