return {
  {
    "mikavilpas/yazi.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>ya",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>yw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        "<leader>yt",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    opts = {
      floating_window_scaling_factor = 0.8,
      keymaps = {
        show_help = "?",
        open_file_in_vertical_split = "<c-v>",
        open_file_in_horizontal_split = "<c-s>",
        open_file_in_tab = "<c-t>",
        grep_in_directory = "<c-g>",
        replace_in_directory = "<c-r>",
        cycle_open_buffers = "<tab>",
        copy_relative_path_to_selected_files = "<c-y>",
        send_to_quickfix_list = "<c-q>",
        change_working_directory = "<c-\\>",
      },
      integrations = {
        --- What should be done when the user wants to grep in a directory
        grep_in_directory = function(directory)
          -- the default implementation uses telescope if available, otherwise nothing
          require("snacks").picker.grep()
        end,
        grep_in_selected_files = function(selected_files)
          -- similar to grep_in_directory, but for selected files
          require("snacks").picker.grep()
        end,
        --- Similarly, search and replace in the files in the directory
        replace_in_directory = function(directory)
          -- default: grug-far.nvim
        end,
        replace_in_selected_files = function(selected_files)
          -- default: grug-far.nvim
        end,
        -- `grealpath` on OSX, (GNU) `realpath` otherwise
        resolve_relative_path_application = "",
      },
    },
  },
}
