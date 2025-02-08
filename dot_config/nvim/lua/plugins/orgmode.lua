return {
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    dependencies = {
      "danilshvalov/org-modern.nvim",
    },
    opts = {
      org_agenda_files = {
        "~/OneDrive/orgfiles/work/*.org",
        "~/OneDrive/orgfiles/*.org",
        "~/OneDrive/orgfiles/private/*.org",
      },
      org_default_notes_file = "~/OneDrive/orgfiles" .. "/refile.org",
      org_todo_keywords = { "TODO(t)", "NEXT", "WAITING", "BUG", "|", "CANCEL", "DONE" },
      ui = {
        folds = {
          colored = false,
        },
        menu = {
          handler = function(data)
            require("org-modern.menu")
              :new({
                window = {
                  margin = { 1, 30, 25, 30 },
                  padding = { 0, 1, 0, 1 },
                  title_pos = "center",
                  border = "double",
                  zindex = 1000,
                },
                icons = {
                  separator = "➜",
                },
              })
              :open(data)
          end,
        },
      },
      org_startup_folded = "inherit",
      org_capture_templates = {
        T = { description = "Task", template = "* TODO %?\n  DEADLINE: %t" },
        t = "TODO ",
        tw = {
          description = "works Tasks",
          template = "* TODO [#C] %?\n  DEADLINE: %t",
          target = "~/OneDrive/orgfiles" .. "/work.org",
        },
        tp = {
          description = "personal Tasks",
          template = "* TODO [#C] %?\n  DEADLINE: %t",
          target = "~/OneDrive/orgfiles" .. "/personal.org",
        },
      },
      mappings = {
        global = {
          org_agenda = "<leader>oga",
          org_capture = "<leader>ogc",
        },
      },
    },
  },
  {
    "akinsho/org-bullets.nvim",
    ft = { "org" },
    opts = {
      symbols = { headlines = { "󰎥 ", "󰎨 ", "󰎫 ", "󰎲 " } },
    },
  },
  -- {
  --   "lukas-reineke/headlines.nvim",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   ft = { "org" },
  --   opts = {
  --     markdown = {
  --       headline_highlights = false,
  --     },
  --   },
  -- },
}
