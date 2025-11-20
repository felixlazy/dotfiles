return {
  "monaqa/dial.nvim",
  opts = function(_, opts)
    local augend = require("dial.augend")
    opts.groups.c = {
      augend.constant.new({
        elements = { "RESET", "SET" },
        word = false,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "HIGH", "LOW" },
        word = false,
        cyclic = true,
      }),
      augend.constant.new({
        elements = {
          "GPIO_SPEED_FREQ_LOW",
          "GPIO_SPEED_FREQ_MEDIUM",
          "GPIO_SPEED_FREQ_HIGH",
          "GPIO_SPEED_FREQ_VERY_HIGH",
        },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = {
          "GPIOA",
          "GPIOB",
          "GPIOC",
          "GPIOD",
          "GPIOE",
          "GPIOF",
          "GPIOG",
        },
        word = false,
        cyclic = true,
      }),
      augend.constant.new({
        elements = {
          "ENABLE",
          "DISABLE",
        },
        word = false,
        cyclic = true,
      }),
    }
    opts.dials_by_ft.c = "c"
    return opts
  end,
}
