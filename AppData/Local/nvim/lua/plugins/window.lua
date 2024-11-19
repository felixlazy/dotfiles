--窗口快速移动
return {
  {
    "s1n7ax/nvim-window-picker",
    event = { "WinNew" },
    keys = {
      {
        "<leader>wj",
        function()
          local picked_window_id = require("window-picker").pick_window({
            include_current_win = true,
          }) or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(picked_window_id)
        end,
        { desc = "Pick a window" },
        {
          "<leader>wJ",
          function()
            local window = require("window-picker").pick_window({
              include_current_win = false,
            })
            local target_buffer = vim.fn.winbufnr(window)
            -- Set the target window to contain current buffer
            vim.api.nvim_win_set_buf(window, 0)
            -- Set current window to contain target buffer
            vim.api.nvim_win_set_buf(0, target_buffer)
          end,
          { desc = "Swap windows" },
        },
      },
    },
    opts = {

      hint = "floating-big-letter",
    },
  },
}
