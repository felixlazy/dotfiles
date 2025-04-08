return {
  {
    "nvim-orgmode/orgmode",
    keys = {
      { "<leader>oga", "<cmd>Org agenda<cr>", desc = "org agenda" },
      { "<leader>ogc", "<cmd>Org capture<cr>", desc = "org capture" },
    },
    ft = { "org" },
    dependencies = {
      "danilshvalov/org-modern.nvim",
    },
    opts = {
      org_agenda_files = {
        "~/OneDrive/PARA/**/*",
      },
      win_split_mode = "float",
      org_default_notes_file = "~/OneDrive/obsidian/archive" .. "/refile.org",
      org_todo_keywords = {
        "TODO(t)",
        "NEXT(n)",
        "WAITING(w)",
        "BUG(b)",
        "FIXED(f)",
        "|",
        "CANCEL(c)",
        "DONE(d)",
        "CLOSED(x)",
      },
      org_todo_keyword_faces = {
        WAITING = ":foreground #ffc777 :weight bold",
        NEXT = "foreground #ff757f :slant",
        FIXED = "foreground #73daca :slant",
        FIX = "foreground #89ddff :slant",
        TODO = "foreground #4fd6be:slant",
        DONE = "foreground #2f334d:slant",
        CANCLE = "foreground #2f334d:slant",
        CLOSED = "foreground #2f334d:slant",
      },
      org_time_stamp_rounding_minutes = 1,
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
          target = "~/OneDrive/obsidian/area/" .. "wokr/work.org",
        },
        tp = {
          description = "personal Tasks",
          template = "* TODO [#C] %?\n  DEADLINE: %t",
          target = "~/OneDrive/obsidian/area/" .. "personal/personal.org",
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
    "nvim-orgmode/org-bullets.nvim",
    ft = { "org" },
    opts = {
      symbols = {
        list = "",
        headlines = { "󰎥 ", "󰎨 ", "󰎫 ", "󰎲 " },
        checkboxes = {
          half = { "", "@org.checkbox.halfchecked" },
          todo = { "", "@org.keyword.todo" },
        },
      },
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
