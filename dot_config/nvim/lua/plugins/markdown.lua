return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = {
        -- general
        width = "block",
        min_width = 80,
        -- borders
        border = "thin",
        left_pad = 1,
        right_pad = 1,
        -- language info
        position = "left",
        language_icon = true,
        language_name = true,
        -- avoid making headings ugly
        highlight_inline = "RenderMarkdownCodeInfo",
      },
      heading = {
        icons = { " 󰼏 ", " 󰎨 ", " 󰼑 ", " 󰎲 ", " 󰼓 ", " 󰎴 " },
        border = true,
        render_modes = true, -- keep rendering while inserting
      },

      pipe_table = {
        alignment_indicator = "─",
        border = { "╭", "┬", "╮", "├", "┼", "┤", "╰", "┴", "╯", "│", "─" },
      },
      link = {
        wiki = { icon = " ", highlight = "RenderMarkdownWikiLink", scope_highlight = "RenderMarkdownWikiLink" },
        image = " ",
        custom = {
          github = { pattern = "github", icon = " " },
          gitlab = { pattern = "gitlab", icon = "󰮠 " },
          youtube = { pattern = "youtube", icon = " " },
          cern = { pattern = "cern.ch", icon = " " },
        },
      },
      anti_conceal = {
        disabled_modes = { "n" },
        ignore = {
          bullet = true, -- render bullet in insert mode
          head_border = true,
          head_background = true,
        },
      },
      -- https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/509
      win_options = { concealcursor = { rendered = "nvc" } },
      completions = {
        blink = { enabled = true },
        lsp = { enabled = true },
      },
      checkbox = {
        enabled = true,
        right_pad = 0,
        custom = {
          question = { raw = "[?]", rendered = " ", highlight = "RenderMarkdownError" },
          ongoing = { raw = "[/]", rendered = " ", highlight = "RenderMarkdownSuccess" },
          bookmart = { raw = "[b]", rendered = " ", highlight = "ObsidianTilde" },
          important = { raw = "[!]", rendered = " ", highlight = "RenderMarkdownWarn" },
          cancelled = { raw = "[-]", rendered = " ", highlight = "RenderMarkdownWarn" },
          favorite = { raw = "[*]", rendered = " ", highlight = "RenderMarkdownMath" },
          location = { raw = "[i]", rendered = " ", highlight = "RenderMarkdownWarn" },
          rescheduled = { raw = "[>]", rendered = "󰄼 ", highlight = "RenderMarkdownh1" },
          note = { raw = "[n]", rendered = " ", highlight = "RenderMarkdownMath" },
          number1 = { raw = "[1]", rendered = "󰲠 ", highlight = "RenderMarkdownSuccess" },
          number2 = { raw = "[2]", rendered = "󰲢 ", highlight = "RenderMarkdownInfo" },
          number3 = { raw = "[3]", rendered = "󰲤 ", highlight = "RenderMarkdownHint" },
          number4 = { raw = "[4]", rendered = "󰲦 ", highlight = "RenderMarkdownWarn" },
          number5 = { raw = "[5]", rendered = "󰲨 ", highlight = "RenderMarkdownH1" },
          number6 = { raw = "[6]", rendered = "󰲪 ", highlight = "RenderMarkdownH2" },
          number7 = { raw = "[7]", rendered = "󰲬 ", highlight = "RenderMarkdownH3" },
          number8 = { raw = "[8]", rendered = "󰲮 ", highlight = "RenderMarkdownH4" },
          number9 = { raw = "[9]", rendered = "󰲰 ", highlight = "RenderMarkdownH5" },
        },
      },
    },
  },
  {
    "HakonHarnes/img-clip.nvim",
    ft = "markdown",
    opts = {
      default = {
        dir_path = "./image", ---@type string | fun(): string
        relative_to_current_file = true,
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

  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    opts = {
      theme = "dark",
      app = "browser",
    },
    keys = {
      {
        "<leader>cp",
        function()
          require("peek").open()
        end,
      },
    },
  },
  { "markdown-preview.nvim", enabled = false },
}
