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
        require("tokyonight").setup({
          on_highlights = function(highlights, colors)
            highlights["@org.agenda.deadline"] = { italic = true, fg = "#ff757f" }
            highlights["@org.agenda.scheduled"] = { italic = true, fg = "#c3e88d" }
            highlights["@org.agenda.scheduled_past"] = { italic = true, fg = "#c3e88d" }
            highlights["@org.agenda.day"] = { italic = true, fg = "#fca7ea" }
            highlights["@org.agenda.today"] = { italic = true, fg = "#ff966c" }
            highlights["@org.agenda.weekend"] = { italic = true, fg = "#4fd6be" }
            highlights["@org.priority.highest"] = { italic = true, fg = "#e26a75" }
            highlights["@org.priority.high"] = { italic = true, fg = "#e26a75" }
            highlights["@org.priority.default"] = { italic = true, fg = "#41a6b5" }
            highlights["@org.priority.low"] = { italic = true, fg = "#c099ff" }
            highlights["@org.priority.lowest"] = { italic = true, fg = "#c099ff" }
          end,
        })
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

  { "fei6409/log-highlight.nvim", event = "BufRead *.log", opts = {} },
}
