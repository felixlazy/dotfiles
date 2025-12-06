return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = {
      map_c_h = true, -- Map the <C-h> key to delete a pair
      map_c_w = true, -- map <c-w> to delete a pair if possible
    },
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    "nvim-mini/mini.pairs",
    enabled = false,
  },
}
