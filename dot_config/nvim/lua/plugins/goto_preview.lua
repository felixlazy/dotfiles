--预览窗口
return {
  "rmagatti/goto-preview",
  lazy = true,
  keys = {
    {
      "gpd",
      "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
      desc = "goto_preview_definition",
    },
    {
      "gpt",
      "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
      desc = "goto_preview_type_definition",
    },
    {
      "gpi",
      "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
      desc = "goto_preview_implementation",
    },
    {
      "gpD",
      "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
      desc = "goto_preview_declaration",
    },
    { "<leader>q", "<cmd>lua require('goto-preview').close_all_win()<CR>", desc = "close_all_win" },
    {
      "gpr",
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
