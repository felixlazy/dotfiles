return {
  "gregorias/coerce.nvim",
  keys = {
    {
      "cr",
      function()
        require("which-key").show({ keys = "cr" })
      end,
      desc = "Coerce word",
    },
    {
      "gcr",
      function()
        require("which-key").show({ keys = "gcr" })
      end,
      desc = "Coerce motion",
    },
    {
      "gcr",
      function()
        require("which-key").show({ keys = "gcr" })
      end,
      mode = "x",
      desc = "Coerce visual",
    },
  },
  opts = function(_, opts)
    require("coerce").setup(opts) -- 初始化插件

    local ok, wk = pcall(require, "which-key")
    if ok then
      local wke = require("coerce.keymaps").which_key_expand
      -- 手动向 which-key 注册动态扩展 (expand)
      wk.add({
        { "cr", group = "Coerce word", expand = wke.normal_mode, mode = "n" },
        { "gcr", group = "Coerce motion", expand = wke.motion_mode, mode = "n" },
        { "gcr", group = "Coerce visual", expand = wke.visual_mode, mode = "x" },
      })
    end
    return opts
  end,
}
