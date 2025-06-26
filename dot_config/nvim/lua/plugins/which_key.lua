return {
  "folke/which-key.nvim",
  keys = {
    {
      "<space>d<space>",
      function()
        require("which-key").show({ keys = "<space>d", loop = true })
      end,
      desc = "debug Hydra Mode (which-key)",
    },
  },
  opts = function(_, opts)
    opts.plugins = vim.tbl_deep_extend("force", opts.plugins or {}, {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      presets = {
        operators = false, -- adds help for operators like d, y, ...
        motions = false, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = false, -- misc bindings to work with windows
        z = false, -- bindings for folds, spelling and others prefixed with z
        g = false, -- bindings for prefixed with g
      },
    })
    opts.triggers = {}
  end,
}
