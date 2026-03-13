return {
  "neovim/nvim-lspconfig",
  build = "npm install devicetree-language-server",
  opts = function(_, opts)
    -- 禁用 Mason 管理
    opts.servers.devicetree_ls = nil

    local lspconfig = require("lspconfig")
    local configs = require("lspconfig.configs")
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- 辅助变量：兼容不同系统的重定向和引用
    local is_windows = vim.fn.has("win32") == 1
    local null_redirect = " 2>/dev/null"
    local quote = "'"

    if is_windows then
      quote = '"' -- Windows (cmd/pwsh) 统一使用双引号
      if vim.o.shell:find("pwsh") or vim.o.shell:find("powershell") then
        null_redirect = " 2>$null"
      else
        null_redirect = " 2>nul"
      end
    end

    -- 辅助函数：获取 shell 命令结果 (使用列表避免 Windows 下产生 null 文件)
    local function get_cmd_output(cmd_args)
      local obj = vim.fn.system(cmd_args)
      if vim.v.shell_error ~= 0 then
        return nil
      end
      local result = obj:gsub("%s+", "")
      return (result ~= "") and result or nil
    end

    -- 获取路径 (Zephyr Idiomatic Way)
    local zephyr_base = os.getenv("ZEPHYR_BASE") or get_cmd_output({ "west", "config", "zephyr.base" }) or ""
    local west_root = get_cmd_output({ "west", "topdir" }) or ""

    local include_paths = {
      zephyr_base .. "/include",
      zephyr_base .. "/dts",
      zephyr_base .. "/dts/common",
      zephyr_base .. "/dts/arm",
      zephyr_base .. "/dts/vendor",
    }
    local binding_paths = { zephyr_base .. "/dts/bindings" }

    -- 使用 west list 直接获取所有模块路径 (传入 table 避免引号转义)
    if west_root ~= "" then
      local modules = vim.fn.systemlist({ "west", "list", "-f", "{path}" })
      if vim.v.shell_error == 0 then
        for _, path in ipairs(modules) do
          local abs_path = west_root .. "/" .. path
          table.insert(include_paths, abs_path .. "/dts")
          table.insert(binding_paths, abs_path .. "/bindings")
          table.insert(include_paths, abs_path .. "/dts/st")
          table.insert(include_paths, abs_path .. "/dts/st/g0")
        end
      end
      table.insert(include_paths, west_root .. "/modules")
    end

    -- 语义标记配置
    capabilities.textDocument = capabilities.textDocument or {}
    capabilities.textDocument.semanticTokens = {
      dynamicRegistration = false,
      requests = { range = false, full = true },
      tokenTypes = {
        "namespace",
        "class",
        "enum",
        "interface",
        "struct",
        "typeParameter",
        "type",
        "parameter",
        "variable",
        "property",
        "enumMember",
        "decorator",
        "event",
        "function",
        "method",
        "macro",
        "label",
        "comment",
        "string",
        "keyword",
        "number",
        "regexp",
        "operator",
      },
      tokenModifiers = {
        "declaration",
        "definition",
        "readonly",
        "static",
        "deprecated",
        "abstract",
        "async",
        "modification",
        "documentation",
        "defaultLibrary",
      },
      formats = { "relative" },
    }

    local devicetree_settings = {
      devicetree = {
        defaultIncludePaths = include_paths,
        cwd = "${workspaceFolder}",
        defaultBindingType = "Zephyr",
        defaultZephyrBindings = binding_paths,
        autoChangeContext = true,
        allowAdhocContexts = true,
      },
    }

    if not configs.devicetree_ls then
      configs.devicetree_ls = {
        default_config = {
          cmd = { "devicetree-language-server", "--stdio" },
          filetypes = { "dts", "dtsi" },
          root_dir = lspconfig.util.root_pattern(".git"),
          settings = devicetree_settings,
          capabilities = capabilities,
        },
      }
    end

    -- Setup the LSP
    lspconfig.devicetree_ls.setup({
      capabilities = capabilities,
      settings = devicetree_settings,
      on_attach = function(client, bufnr)
        vim.bo[bufnr].expandtab = false
        vim.bo[bufnr].shiftwidth = 8
        vim.bo[bufnr].tabstop = 8
        vim.bo[bufnr].softtabstop = 8

        if client.server_capabilities then
          client.server_capabilities.definitionProvider = true
        end
      end,
      -- 客户端拦截：即使还是有报警，也直接屏蔽掉
      handlers = {
        ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
          if result.diagnostics then
            local filtered = {}
            for _, d in ipairs(result.diagnostics) do
              -- 屏蔽所有关于缩进的报警
              if not d.message:lower():find("indentation") and not d.message:lower():find("expecting") then
                table.insert(filtered, d)
              end
            end
            result.diagnostics = filtered
          end
          vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
        end,
      },
    })

    if not require("lspconfig.configs").kconfig then
      configs.kconfig = {
        default_config = {
          cmd = { "kconfig-lsp" },
          filetypes = { "kconfig" },
          root_dir = zephyr_base,
          settings = {
            kconfig = {
              zephyrBase = zephyr_base,
            },
          },
          capabilities = capabilities,
        },
      }
    end

    lspconfig.kconfig.setup({
      capabilities = capabilities, -- 建议传入你定义的 capabilities
      handlers = {
        ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
          -- 如果文件路径以 .conf 结尾，直接清空诊断信息（错误列表）
          if result.uri:match("%.conf$") then
            result.diagnostics = {}
          end
          vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
        end,
      },
    })
    return opts
  end,
}
