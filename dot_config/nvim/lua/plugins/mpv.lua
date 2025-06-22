return {
  "felixlazy/mpv.nvim",
  branch = "develop",
  dependencies = {
    {
      "nvim-lualine/lualine.nvim",
      opts = function(_, opts)
        table.insert(opts.sections.lualine_x, 1, {
          function()
            title = require("mpv.ipc").title
            if title == nil or title == "" then
              return ""
            end
            return " " .. require("mpv.ipc").title
          end,
          color = "@comment.todo",
        })
      end,
    },
  },
  keys = {
    { "<leader>mi", "<cmd>MpvInfo<cr>", desc = "Show mpv current info" },
    { "<leader>m>", "<cmd>MpvNext<cr>", desc = "Play next item" },
    { "<leader>m<", "<cmd>MpvPrev<cr>", desc = "Play previous item" },
    { "<leader>mk", "<cmd>MpvVolumeUp<cr>", desc = "Increase volume" },
    { "<leader>mj", "<cmd>MpvVolumeDown<cr>", desc = "Decrease volume" },
    { "<leader>mp", "<cmd>MpvPause<cr>", desc = "Play/Pause" },
    { "<leader>mo", "<cmd>MpvPicker<cr>", desc = "Pick file to play" },
    { "<leader>ml", "<cmd>MpvSeekForward<cr>", desc = "Seek forward 5 seconds" },
    { "<leader>mh", "<cmd>MpvSeekBackward<cr>", desc = "Seek backward 5 seconds" },
    { "<leader>mL", "<cmd>MpvSeekForward 60<cr>", desc = "Seek forward 60 seconds" },
    { "<leader>mH", "<cmd>MpvSeekBackward 60<cr>", desc = "Seek backward 60 seconds" },
    { "<leader>m+", "<cmd>MpvSpeedUp<cr>", desc = "Increase speed by 0.1" },
    { "<leader>m-", "<cmd>MpvSpeedDown<cr>", desc = "Decrease speed by 0.1" },
    { "<leader>mq", "<cmd>MpvQuit<cr>", desc = "Quit mpv" },
  },
  cmd = {
    "MpvInfo",
    "MpvNext",
    "MpvPrev",
    "MpvVolumeUp",
    "MpvVolumDown",
    "MpvPause",
    "MpvPlay",
    "MpvPicker",
    "MpvSeekBackward",
    "MpvSeekForward",
    "MpvSpeed",
    "MpvGetPath",
    "MpvQuit",
  },
  opts = {
    ipc_name = "mpv_ipc",
    music_path = "~/OneDrive/PARA/resource/music",
  },
}
