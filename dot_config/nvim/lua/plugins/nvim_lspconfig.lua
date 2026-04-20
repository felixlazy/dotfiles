return {
  "neovim/nvim-lspconfig",
  build = "npm install --save-dev devicetree-language-server && cargo install kconfig-lsp --root .",
  opts = function(_, opts)
    -- 禁用 Mason 对特定 server 的管理（如果需要手动控制）
    opts.servers.devicetree_ls = nil
    opts.servers.kconfig = nil

    -- 调用提取出来的 Zephyr 相关 LSP 配置
    local status_ok, zephyr = pcall(require, "lsp.zephyr")
    if status_ok then
      -- 使用 LazyVim 已经配置好的 capabilities (通常在 opts.capabilities 中)
      -- 如果没有，则回退到默认的
      local capabilities = opts.capabilities or vim.lsp.protocol.make_client_capabilities()
      zephyr.setup(capabilities)
    end

    return opts
  end,
}
