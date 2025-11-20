return {
  "nvim-mini/mini.ai",
  opts = function(_, opts)
    table.insert(opts.custom_textobjects.e[1], "%f[%S]%u+%f[^%u%l%d]")
    table.insert(opts.custom_textobjects.e[1], "%f[%P]%u+%f[^%u%l%d]")
    return opts
  end,
}
