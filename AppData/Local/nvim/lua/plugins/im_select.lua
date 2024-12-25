--输入法切换
return {
  {
    "keaising/im-select.nvim",
    event = "InsertEnter",
    config = function()
      require("im_select").setup({})
    end,
  },
}
