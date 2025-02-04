return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "saghen/blink.compat",
      "xzbdmw/colorful-menu.nvim",
    },
    opts = {
      keymap = {
        cmdline = {
          preset = "super-tab",
          ["<CR>"] = {},
          ["<C-y>"] = { "select_and_accept" },
        },
      },
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "orgmode",
          "obsidian",
          "obsidian_new",
          "obsidian_tags",
          "markdown",
        },
        providers = {
          orgmode = {
            name = "Orgmode",
            module = "orgmode.org.autocompletion.blink",
          },
          obsidian = {
            name = "obsidian",
            module = "blink.compat.source",
          },
          obsidian_new = {
            name = "obsidian_new",
            module = "blink.compat.source",
          },
          obsidian_tags = {
            name = "obsidian_tags",
            module = "blink.compat.source",
          },
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
            fallbacks = { "lsp" },
          },
        },
        cmdline = function()
          local type = vim.fn.getcmdtype()
          -- Search forward and backward
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          -- Commands
          if type == ":" or type == "@" then
            return { "cmdline" }
          end
          return {}
        end,
      },
      completion = {
        menu = {
          border = "single",
          draw = {
            treesitter = { "lsp" },
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
          scrollbar = false,
        },
        documentation = {
          window = { border = "single", scrollbar = false },
          auto_show = true,
          auto_show_delay_ms = 500,
        },
      },
      signature = {
        enabled = true,
        window = { border = "single" },
      },
      appearance = {
        nerd_font_variant = "normal",
      },
    },
  },
}
