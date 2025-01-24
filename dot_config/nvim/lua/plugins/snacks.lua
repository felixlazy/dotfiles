return {
  "folke/snacks.nvim",
  opts = {
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
        git = {
          native = true, -- use native (terminal) or Neovim for previewing git diffs and commits
        },
      },
    },
  },
}
