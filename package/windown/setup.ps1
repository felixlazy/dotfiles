Write-Host "开始安装需要的软件"

# 安装 scoop
function install_scoop {
  if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "scoop 未安装，开始安装 scoop"
    # 设置执行策略以允许安装脚本运行
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    # 下载并执行 scoop 安装脚本
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
    # 添加常用的 bucket
    scoop bucket add main
    scoop bucket add extras
    scoop bucket add nerd-fonts
  }
  else {
    Write-Host "scoop 已安装"
  }
}

# 安装 Catppuccin 主题
function catppuccin {
  # 检查 Catppuccin 模块是否已存在
  if (-not (Get-Module -ListAvailable -Name Catppuccin)) {
    Write-Host "安装 Catppuccin 主题"
    # 将 Catppuccin 主题克隆到 scoop 的 modules 目录中
    git clone https://github.com/catppuccin/powershell.git $env:scoop/modules/catppuccin
    # 导入模块
    Import-Module $env:scoop/modules/catppuccin/Catppuccin.psm1
  }
  else {
    Write-Host "Catppuccin 主题已安装"
    Import-Module Catppuccin
  }
}

# 使用 pip 安装 Python 包
function pip_install($command) {
  # 检查命令是否已存在
  if (-not (Get-Command -Name $command -ErrorAction SilentlyContinue)) {
    Write-Host "$command 软件不存在, 开始使用 pip 下载 $command"
    pip install $command
    # 检查安装是否成功
    if ($LASTEXITCODE -ne 0) {
      Write-Host "pip install $command 失败，请检查网络或手动安装。" -ForegroundColor Red
    }
    else {
      Write-Host "$command 软件安装完成"
    }
  }
  else {
    Write-Host "$command 软件已安装"
  }
}

# 使用 npm 安装 Node.js 包
function npm_install($command) {
  # 检查命令是否已存在
  if (-not (Get-Command -Name $command -ErrorAction SilentlyContinue)) {
    Write-Host "$command 软件不存在, 开始使用 npm 下载 $command"
    npm install -g $command
    # 检查安装是否成功
    if ($LASTEXITCODE -ne 0) {
      Write-Host "npm install -g $command 失败，请检查网络或手动安装。" -ForegroundColor Red
    }
    else {
      Write-Host "$command 软件安装完成"
    }
  }
  else {
    Write-Host "$command 软件已安装"
  }
}

# 安装 PowerShell 模块
function import_module($command) {
  # 检查模块是否已安装
  if (-not (Get-Module -Name $command -ListAvailable)) {
    Write-Host "开始安装 PowerShell 模块 $command"
    Install-Module $command -Scope CurrentUser -Force -Confirm:$false
  }
  else {
    Write-Host "PowerShell 模块 $command 已安装"
  }
}

# 配置 PSCompletions
function PSCompletions_config {
  # 检查 PSCompletions 模块是否已安装
  if (Get-Module -Name PSCompletions -ListAvailable) {
    Write-Host "配置 PSCompletions..."
    # 获取已有的补全源
    $existing_completions = PSCompletions list
    # 需要添加的补全源列表
    $completions_to_add = @("npm", "pip", "cargo", "scoop", "git")

    foreach ($completion in $completions_to_add) {
      # 检查补全源是否已存在
      if ($existing_completions -notmatch $completion) {
        PSCompletions add $completion
        Write-Host "$completion 补全源已添加"
      }
      else {
        Write-Host "$completion 补全源已存在"
      }
    }
  }
}

# 批量安装 scoop 软件包
function install_scoop_packages($packages) {
  Write-Host "检查需要安装的 scoop 软件包..."
  $installed_packages = scoop list | ForEach-Object { $_.split(' ')[0] }
  $packages_to_install = @()

  # 找出未安装的软件包
  foreach ($package in $packages) {
    if ($installed_packages -notcontains $package) {
      $packages_to_install += $package
    }
    else {
      Write-Host "$package 已安装"
    }
  }

  # 如果有未安装的包，则一次性安装
  if ($packages_to_install.Count -gt 0) {
    Write-Host "开始安装以下软件包: $($packages_to_install -join ', ')"
    scoop install $packages_to_install
    if ($LASTEXITCODE -ne 0) {
      Write-Host "部分软件包安装失败，请检查 scoop 的输出信息。" -ForegroundColor Red
    }
    else {
      Write-Host "所有请求的软件包均已成功安装。"
    }
  }
  else {
    Write-Host "所有指定的软件包均已安装。"
  }
}

# --- 主执行流程 ---

# 1. 确保 scoop 已安装
install_scoop

# 2. 定义需要通过 scoop 安装的软件包列表
$packages = @(
  "7zip", "aria2", "bat", "bottom", "chezmoi", "dark", "delta", "everything",
  "eza", "fastfetch", "fd", "ffmpeg", "flow-launcher", "fzf", "gcc-arm-none-eabi",
  "geekuninstaller", "gh", "git", "github", "glow", "gsudo", "gzip", "hexyl",
  "imagemagick", "innounp", "jq", "lazygit", "lua", "mingw", "neovide", "neovim",
  "nodejs-lts", "obsidian", "onefetch", "pandoc", "poppler", "posh-git", "psfzf",
  "psreadline", "pwsh", "python", "ripgrep", "rust-analyzer", "rustup", "starship",
  "television", "vscode", "wechat", "wezterm", "windows-terminal", "yazi", "zoxide",
  "Maple-Mono-NF-CN", "gpg", "yt-dlp", "mpv", "deno", "autohotkey"
)

# 3. 安装所有 scoop 软件包
install_scoop_packages $packages

# 4. 安装 PowerShell 主题和模块
catppuccin
import_module "PSCompletions"

# 5. 安装 Python 和 Node.js 包
pip_install "compiledb"
npm_install "@google/gemini-cli"

# 6. 配置补全
PSCompletions_config

# 7. 构建 bat 缓存
bat cache --build

Write-Host "安装完成"