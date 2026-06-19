return {
  "folke/sidekick.nvim",
  opts = function(_, opts)
    local mux = {}
    if vim.fn.has("win32") == 0 then
      mux = {
        backend = "tmux",
        enabled = true,
      }
    else
      mux = {
        backend = "tmux",
        enabled = false,
      }
    end
    opts.cli = {
      prompts = {
        refactor = "Please refactor {this} to be more maintainable",
        security = "Review {file} for security vulnerabilities",
        commit = "Generate commit message with commitizen convention from staged changes",
        translate = "Translate {this} ",
      },
      mux = mux,
      tools = {
        gemini = {
          cmd = { "gemini" },
          env = {
            https_proxy = os.getenv("https_proxy"),
            http_proxy = os.getenv("http_proxy"),
            all_proxy = os.getenv("all_proxy"),
            GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
          },
        },
      },
    }
    return opts
  end,
}
