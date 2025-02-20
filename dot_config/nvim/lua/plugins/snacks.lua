return {
  "folke/snacks.nvim",
  opts = {
    image = { enable = true },
    dashboard = {
      preset = {
        header = [[


███████╗███████╗██╗     ██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗
██╔════╝██╔════╝██║     ██║╚██╗██╔╝██║   ██║██║████╗ ████║
█████╗  █████╗  ██║     ██║ ╚███╔╝ ██║   ██║██║██╔████╔██║
██╔══╝  ██╔══╝  ██║     ██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
██║     ███████╗███████╗██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝     ╚══════╝╚══════╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
                                                          

]],
      },
    },
    indent = {
      enabled = true, -- enable indent guides
      chunk = {
        -- when enabled, scopes will be rendered as chunks, except for the
        -- top-level scope which will be rendered as a scope.
        enabled = true,
        -- only show chunk scopes in the current window
        only_current = true,
        priority = 200,
        hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
        char = {
          -- corner_top = "┌",
          -- corner_bottom = "└",
          corner_top = "╭",
          corner_bottom = "╰",
          horizontal = "─",
          vertical = "│",
          arrow = ">",
        },
      },
    },
    picker = {
      win = {
        input = {
          keys = {
            ["<a-w>"] = { "toggle_preview", mode = { "i", "n" } },
            ["<a-p>"] = { "cycle_win", mode = { "i", "n" } },
          },
        },
        preview = {
          keys = {
            ["<a-p>"] = "cycle_win",
          },
        },
      },
      previewers = {
        diff = {
          builtin = false, -- use Neovim for previewing diffs (true) or use an external tool (false)
          cmd = { "delta" }, -- example to show a diff with delta
        },
        git = {
          builtin = false, -- use Neovim for previewing git output (true) or use git (false)
          args = {}, -- additional arguments passed to the git command. Useful to set pager options usin `-c ...`
        },
      },
    },
    terminal = {},
  },
  keys = {
    {
      "<leader>fz",
      function()
        Snacks.picker.zoxide()
      end,
      desc = "zoxide",
    },
    {
      "<leader>cb",
      function()
        Snacks.picker.git_branches()
      end,
      desc = "git branches",
    },
    {
      "<leader>fs",
      function()
        Snacks.picker.pickers()
      end,
      desc = "pickers",
    },
    {
      "<leader>btm",
      function()
        Snacks.terminal.open("btm")
      end,
      desc = "btm",
    },
  },
}
