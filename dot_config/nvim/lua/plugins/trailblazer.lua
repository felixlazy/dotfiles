--游标操作
return {
  {
    "LeonHeidelbach/trailblazer.nvim",
    lazy = true,
    keys = {
      {
        "<leader>tra",
        "<cmd>TrailBlazerNewTrailMark<CR>",
        desc = "TrailBlazerNewTrailMark",
      },
      {
        "<leader>trd",
        "<cmd>TrailBlazerTrackBack<CR>",
        desc = "TrailBlazerTrackBack",
      },
      {
        "<leader>trD",
        "<cmd>TrailBlazerDeleteAllTrailMarks<CR>",
        desc = "TrailBlazerDeleteAllTrailMarks",
      },
      {
        "<leader>trD",
        "<cmd>TrailBlazerDeleteAllTrailMarks<CR>",
        desc = "TrailBlazerDeleteAllTrailMarks",
      },
      {
        "<leader>trj",
        "<cmd>TrailBlazerPeekMovePreviousUp<CR>",
        desc = "TrailBlazerPeekMovePreviousUp",
      },
      {
        "<leader>trk",
        "<cmd>TrailBlazerPeekMoveNextDown<CR>",
        desc = "TrailBlazerPeekMoveNextDown",
      },
      {
        "<leader>trm",
        "<cmd>TrailBlazerToggleTrailMarkList<CR>",
        desc = "TrailBlazerToggleTrailMarkList",
      },
      {
        "<leader>trp",
        "<cmd>TrailBlazerPasteAtLastTrailMark<CR>",
        desc = "TrailBlazerPasteAtLastTrailMark",
      },
    },
    opts = {
      mappings = { -- rename this to "force_mappings" to completely override default mappings and not merge with them
        nv = { -- Mode union: normal & visual mode. Can be extended by adding i, x, ...
          motions = {
            new_trail_mark = "",
            track_back = "",
            peek_move_next_down = "",
            peek_move_previous_up = "",
            move_to_nearest = "",
            toggle_trail_mark_list = "",
          },
          actions = {
            delete_all_trail_marks = "",
            paste_at_last_trail_mark = "",
            paste_at_all_trail_marks = "",
            set_trail_mark_select_mode = "",
            switch_to_next_trail_mark_stack = "",
            switch_to_previous_trail_mark_stack = "",
            set_trail_mark_stack_sort_mode = "",
          },
        },
      },
    },
  },
}
