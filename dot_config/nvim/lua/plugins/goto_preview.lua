--预览窗口
return {
  "rmagatti/goto-preview",
  lazy = true,
  keys = {
    {
      "<leader>gpd",
      "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
      desc = "goto_preview_definition",
    },
    {
      "<leader>gpt",
      "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
      desc = "goto_preview_type_definition",
    },
    {
      "<leader>gpi",
      "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
      desc = "goto_preview_implementation",
    },
    {
      "<leader>gpD",
      "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
      desc = "goto_preview_declaration",
    },
    { "<leader>gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", desc = "close_all_win" },
    {
      "<leader>gpr",
      "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
      desc = "goto_preview_references",
    },
  },
  opts = {
    width = 80,
    height = 20,
    default_mappings = true,
    debug = false,
    opacity = nil,
    post_open_hook = nil,
  },
}
