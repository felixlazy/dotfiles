return {
  "folke/sidekick.nvim",
  opts = function(_, opts)
    opts.cli = {
      prompts = {
        refactor = "Please refactor {this} to be more maintainable",
        security = "Review {file} for security vulnerabilities",
        translate = "Translate {this} ",
      },
    }
    if vim.fn.has("win32") == 0 then
      opts.cli.mux = {
        backend = "tmux",
        enabled = true,
      }
    end
    return opts
  end,
}
