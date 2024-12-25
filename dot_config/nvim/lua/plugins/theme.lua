return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      transparent_background = true,
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
        dap_ui = true,
        fzf = true,
        nvim_surround = true,
        ts_rainbow2 = true,
        window_picker = true,
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      if true then
      else
        require("tokyonight").setup({
          transparent = true,
          terminal_colors = true,
          styles = {
            comments = { italic = true },
            keywords = { bold = true, italic = true },
            sidebars = "transparent",
            floats = "transparent",
          },
          plugins = {
            all = true,
          },
          on_colors = function(colors) end,
          on_highlights = function(highlights, colors)
            highlights.LspInlayHint = {
              bg = colors.none,
              fg = colors.dark3,
            }
            highlights.Statement = { fg = colors.magenta, italic = true, bold = true }
            highlights.Type = { fg = colors.blue1, bold = true }
            highlights["@lsp.type.rust"] = { italic = true, fg = colors.red1 }
            highlights.Visual = { reverse = true, bg = "#2d3f76" }
            highlights.treesitterContext = { bg = none }
          end,
        })
      end
    end,
  },
}
