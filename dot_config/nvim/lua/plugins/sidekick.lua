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
            https_proxy = "http://127.0.0.1:7890",
            http_proxy = "http://127.0.0.1:7890",
            all_proxy = "socks5://127.0.0.1:7890",
          },
        },
      },
    }
    return opts
  end,
}
