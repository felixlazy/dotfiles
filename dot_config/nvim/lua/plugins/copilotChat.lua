return {
  "CopilotC-Nvim/CopilotChat.nvim",
  opts = {
    prompts = {
      Explain = {
        prompt = "> /COPILOT_EXPLAIN\n\n用中文为所选代码写一个段落的解释。",
      },
      Translation = {
        prompt = "翻译成中文",
      },
      commit = {
        prompt = "> #git:staged\n\n用中文编写符合 commitizen 规范的提交信息。确保标题最多 50 个字符，消息在 72 个字符处换行。将整个消息用 gitcommit 语言的代码块包裹。",
      },
    },
  },
}
