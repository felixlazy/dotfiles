local M = {}

function M.setup(capabilities)
  local lspconfig = require("lspconfig")
  local configs = require("lspconfig.configs")

  -- 辅助函数：获取 shell 命令结果
  local function get_cmd_output(cmd_args)
    -- 先检查命令是否可执行，防止 vim.fn.system 抛出 E475
    if vim.fn.executable(cmd_args[1]) == 0 then
      return nil
    end
    local obj = vim.fn.system(cmd_args)
    if vim.v.shell_error ~= 0 then
      return nil
    end
    local result = obj:gsub("%s+", "")
    return (result ~= "") and result or nil
  end

  -- 1. Zephyr 环境路径探测 (先尝试环境变量，再尝试 west)
  local zephyr_base = os.getenv("ZEPHYR_BASE") or get_cmd_output({ "west", "config", "zephyr.base" }) or ""
  local west_root = get_cmd_output({ "west", "topdir" }) or ""

  -- 如果完全不在 Zephyr 环境下，直接返回，不注册 LSP
  -- 这样可以防止在非 Zephyr 项目中启动相关客户端
  if zephyr_base == "" and west_root == "" then
    return
  end

  -- 2. 基础环境探测
  local is_windows = vim.fn.has("win32") == 1
  local plugin_dir = vim.fn.stdpath("data") .. "/lazy/nvim-lspconfig"

  -- 路径检测逻辑
  local dt_bin_name = is_windows and "devicetree-language-server.cmd" or "devicetree-language-server"
  local dt_local_bin = plugin_dir .. "/node_modules/.bin/" .. dt_bin_name
  local dt_server_cmd = (vim.fn.executable(dt_local_bin) == 1) and dt_local_bin or "devicetree-language-server"

  local kconfig_bin_name = is_windows and "kconfig-lsp.exe" or "kconfig-lsp"
  local kconfig_local_bin = plugin_dir .. "/bin/" .. kconfig_bin_name
  local kconfig_server_cmd = (vim.fn.executable(kconfig_local_bin) == 1) and kconfig_local_bin or "kconfig-lsp"

  local include_paths = {
    zephyr_base .. "/include",
    zephyr_base .. "/dts",
    zephyr_base .. "/dts/common",
    zephyr_base .. "/dts/arm",
    zephyr_base .. "/dts/vendor",
  }
  local binding_paths = { zephyr_base .. "/dts/bindings" }

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

  -- 4. Devicetree 配置
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
        cmd = { dt_server_cmd, "--stdio" },
        filetypes = { "dts", "dtsi" },
        -- 优先查找工程标志 prj.conf，或者 Git 根目录
        root_dir = lspconfig.util.root_pattern("prj.conf", ".git", "zephyr/module.yml", "CMakeLists.txt"),
        settings = devicetree_settings,
        capabilities = capabilities,
        single_file_support = false,
      },
    }
  end
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
    handlers = {
      ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
        if result.diagnostics then
          local filtered = {}
          for _, d in ipairs(result.diagnostics) do
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

  -- 5. Kconfig 配置
  if not configs.kconfig then
    configs.kconfig = {
      default_config = {
        cmd = { kconfig_server_cmd },
        filetypes = { "kconfig" },
        root_dir = zephyr_base,
        settings = { kconfig = { zephyrBase = zephyr_base } },
        capabilities = capabilities,
        single_file_support = false,
      },
    }
  end

  -- 只有当命令可执行时才 setup
  if vim.fn.executable(kconfig_server_cmd) == 1 then
    lspconfig.kconfig.setup({
      capabilities = capabilities,
      handlers = {
        ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
          if result.uri:match("%.conf$") then
            result.diagnostics = {}
          end
          vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
        end,
      },
    })
  end
end

return M
