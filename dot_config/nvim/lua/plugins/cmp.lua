return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "saghen/blink.compat",
      "xzbdmw/colorful-menu.nvim",
    },
    opts = {
      cmdline = {
        enabled = true,
        keymap = {
          preset = "super-tab",
          ["<CR>"] = {},
          ["<C-y>"] = { "select_and_accept" },
        },
        sources = function()
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
        completion = {
          trigger = {
            show_on_blocked_trigger_characters = {},
            show_on_x_blocked_trigger_characters = nil, -- Inherits from top level `completion.trigger.show_on_blocked_trigger_characters` config when not set
          },
          menu = {
            auto_show = nil, -- Inherits from top level `completion.menu.auto_show` config when not set
            draw = {
              columns = { { "label", "label_description", gap = 1 } },
            },
          },
        },
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
        -- trigger = { show_on_insert_on_trigger_character = true },
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
