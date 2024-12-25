return {
  {
    -- amongst your other plugins
    {
      "akinsho/toggleterm.nvim",
      version = "*",
      keys = {
        { "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", { desc = "ToggleTerm horizontal split" } },
        { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm float" } },
        { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "ToggleTerm vertical split" } },
      },
      opts = {
        highlights = {
          Normal = { link = "Normal" },
          NormalNC = { link = "NormalNC" },
          NormalFloat = { link = "NormalFloat" },
          FloatBorder = { link = "FloatBorder" },
          StatusLine = { link = "StatusLine" },
          StatusLineNC = { link = "StatusLineNC" },
          WinBar = { link = "WinBar" },
          WinBarNC = { link = "WinBarNC" },
        },
        size = 10,
        on_create = function()
          vim.opt.foldcolumn = "0"
          vim.opt.signcolumn = "no"
        end,
        shading_factor = 2,
        direction = "float",
        float_opts = { border = "rounded" },
      },
      config = function()
        require("toggleterm").setup()
        local Terminal = require("toggleterm.terminal").Terminal
        local btm = Terminal:new({
          cmd = "btm",
          dir = "git_dir",
          direction = "float",
          float_opts = {
            border = "double",
          },
          -- function to run on opening the terminal
          on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
          end,
          -- function to run on closing the terminal
          on_close = function(term)
            vim.cmd("startinsert!")
          end,
        })

        function _btm_toggle()
          btm:toggle()
        end

        local gdu = Terminal:new({
          cmd = "gdu",
          dir = "git_dir",
          direction = "float",
          float_opts = {
            border = "double",
          },
          -- function to run on opening the terminal
          on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
          end,
          -- function to run on closing the terminal
          on_close = function(term)
            vim.cmd("startinsert!")
          end,
        })

        function _gdu_toggle()
          gdu:toggle()
        end
        vim.api.nvim_set_keymap("n", "<leader>btm", "<cmd>lua _btm_toggle()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>gdu", "<cmd>lua _gdu_toggle()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
      end,
    },
  },
}
