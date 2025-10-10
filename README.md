# My Dotfiles

一套精心配置的个人点文件，使用 [chezmoi](https://www.chezmoi.io/) 进行管理，旨在提供一个跨平台（Windows & macOS）的、高效且一致的开发环境。

## 平台支持

- [x] **Windows**: 通过 PowerShell 和 Scoop 进行环境配置。
- [x] **macOS**: 通过 Zsh 和 Homebrew 进行环境配置。

---

## 软件栈概览

此仓库包含了以下软件的配置文件，涵盖了从终端、编辑器到各种命令行工具的完整工作流。

### 核心环境

| 类别           | 软件                    |
| :------------- | :---------------------- |
| **终端**       | WezTerm, Ghostty, Kitty |
| **Shell**      | Zsh, PowerShell         |
| **编辑器**     | Neovim (LazyVim)        |
| **Git 客户端** | Lazygit                 |
| **终端复用器** | Tmux                    |

- **终端**: 支持多个现代、GPU 加速的终端，可根据偏好自由选择。配置文件统一了深色主题（Tokyonight）。
- **Shell**:
  - **Zsh**: 使用 `zinit` 作为插件管理器，实现了快速启动和强大的功能扩展。
  - **PowerShell**: 为 Windows 环境定制了配置文件，集成了 `PSFzf`、`Eza` 等工具。
- **Neovim**: 基于 [LazyVim](https://www.lazyvim.org/) 框架，实现了配置的模块化和懒加载，提供开箱即用的代码编辑、文件管理和格式化等功能。

### 命令行与辅助工具

| 类别           | 软件       | 描述                                          |
| :------------- | :--------- | :-------------------------------------------- |
| **命令提示符** | Starship   | 提供美观、快速且高度可定制的跨 Shell 提示符。 |
| **文件列表**   | eza        | `ls` 的现代替代品，提供图标、Git 状态等信息。 |
| **文件预览**   | bat        | `cat` 的替代品，支持语法高亮和 Git 集成。     |
| **模糊搜索**   | fzf        | 强大的命令行模糊搜索工具                      |
| **文件预览器** | television | fzf 的高级文件预览器                          |
| **系统信息**   | fastfetch  | 轻量且快速的系统信息抓取工具。                |

### 平台特定工具

| 平台        | 软件       | 描述                                     |
| :---------- | :--------- | :--------------------------------------- |
| **macOS**   | Aerospace  | 一款基于 i3/Sway 的平铺式窗口管理器。    |
| **Windows** | AutoHotkey | 用于实现系统级快捷键和自动化的脚本工具。 |

---

## 安装与部署

部署分为两步：安装基础软件包和应用 `chezmoi` 配置。

### 1. 安装软件包

- **Windows**:

  以管理员身份运行 PowerShell，并执行 `setup.ps1` 脚本来安装 Scoop 和所有必要的软件包。

  ```powershell
  # 导航到仓库目录
  # cd path\to\dotfiles\package\windown
  .\setup.ps1
  ```

- **macOS**:

  使用 Homebrew 安装 `Brewfile` 中定义的所有软件包。

  ```bash
  # 导航到仓库目录
  # cd path/to/dotfiles/package/darwin
  brew bundle
  ```

### 2. 应用配置文件

安装完所有软件包后，使用 `chezmoi` 来链接所有配置文件。

```bash
# 替换为你的仓库地址
chezmoi init --apply https://github.com/Wu-Felix/dotfiles.git
```

> [!WARNING]
>
> **Windows 用户请注意**:
> 应用此配置会通过 `run_onchange_` 脚本修改注册表，主要用于：
>
> - 禁用 Edge 等浏览器的 `Ctrl+N` 新建窗口快捷键。
> - 将 `Caps Lock` (大写锁定) 键映射为 `Ctrl`。
>
> 请在执行前确认并了解相关脚本。
