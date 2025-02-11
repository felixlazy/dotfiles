return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      -- transparent_background = true,
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
