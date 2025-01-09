return {
  {
    "saghen/blink.cmp",
    dependencies = { "saghen/blink.compat" },
    opts = {
      keymap = {
        cmdline = {
          preset = "enter",
          ["<CR>"] = {},
          ["<C-y>"] = { "select_and_accept" },
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "orgmode", "obsidian", "obsidian_new", "obsidian_tags" },
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
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
            treesitter = { "lsp" },
          },
          scrollbar = false,
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
      },
      signature = {
        enabled = true,
      },
      appearance = {
        nerd_font_variant = "normal",
      },
    },
  },
}
