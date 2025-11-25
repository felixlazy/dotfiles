$ErrorActionPreference = "Stop"

Write-Host "==> Setting up Scoop and packages..." -ForegroundColor Cyan

# Install Scoop if not already installed
if (!(Get-Command scoop -ErrorAction SilentlyContinue))
{
  Write-Host "Installing Scoop..." -ForegroundColor Yellow
  Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
  scoop install git # needed to add buckets
} else
{
  Write-Host "Updating Scoop..." -ForegroundColor Yellow
  scoop update > $null
}

# Add useful buckets
Write-Host "Adding Scoop buckets..." -ForegroundColor Yellow
$buckets = @('extras', 'versions', 'nerd-fonts', 'main')
$installedBuckets = (scoop bucket list).Name
foreach ($bucket in $buckets)
{
  if ($installedBuckets -notcontains $bucket)
  {
    Write-Host "Adding bucket: $bucket" -ForegroundColor Yellow
    scoop bucket add $bucket
  }
}

# Core development tools
$packages = @(
  "7zip",
  "aria2",
  "autohotkey",
  "bat",
  "bottom",
  "chezmoi",
  "clangd",
  "clash-verge-rev",
  "cmake",
  "curl",
  "dark",
  "delta",
  "deno",
  "duf",
  "everything",
  "eza",
  "fastfetch",
  "fd",
  "ffmpeg",
  "flow-launcher",
  "frp",
  "fzf",
  "gcc",
  "gcc-arm-none-eabi",
  "gdu",
  "geekuninstaller",
  "gh",
  "ghostscript",
  "git",
  "github",
  "glow",
  "gotop",
  "gpg",
  "graphviz",
  "gsudo",
  "gzip",
  "hexyl",
  "hyperfine",
  "imagemagick",
  "innounp",
  "jq",
  "lazygit"
  "llvm",
  "lua51",
  "luajit",
  "Maple-Mono-NF-CN",
  "mediainfo",
  "mingw",
  "mpv",
  "neovide",
  "neovim",
  "nodejs-lts",
  "obsidian",
  "onefetch",
  "openjdk21",
  "openocd",
  "pandoc",
  "pkg-config",
  "poppler",
  "posh-git",
  "procs",
  "psfzf",
  "psreadline"
  "pwsh",
  "python",
  "ripgrep",
  "rust-analyzer",
  "rustup",
  "sharpkeys",
  "sqlite",
  "starship",
  "tectonic",
  "television",
  "typioca",
  "vscode",
  "wezterm",
  "windows-terminal",
  "yazi",
  "yt-dlp",
  "zen-browser",
  "zoxide",
  "pscompletions"
)

Write-Host "Installing packages..." -ForegroundColor Yellow
scoop install $packages

# Update all installed packages
Write-Host "Updating packages..." -ForegroundColor Yellow
scoop update *


# 安装 Catppuccin 主题
function catppuccin
{
  # 检查 Catppuccin 模块是否已存在
  if (-not (Get-Module -ListAvailable -Name Catppuccin))
  {
    Write-Host "安装 Catppuccin 主题"
    # 将 Catppuccin 主题克隆到 scoop 的 modules 目录中
    git clone https://github.com/catppuccin/powershell.git $env:scoop/modules/catppuccin
    # 导入模块
    Import-Module $env:scoop/modules/catppuccin/Catppuccin.psm1
  } else
  {
    Write-Host "Catppuccin 主题已安装"
    Import-Module Catppuccin
  }
}

# 使用 pip 安装 Python 包
function pip_install($command)
{
  # 检查命令是否已存在
  if (-not (Get-Command -Name $command -ErrorAction SilentlyContinue))
  {
    Write-Host "$command 软件不存在, 开始使用 pip 下载 $command"
    pip install $command
    # 检查安装是否成功
    if ($LASTEXITCODE -ne 0)
    {
      Write-Host "pip install $command 失败，请检查网络或手动安装。" -ForegroundColor Red
    } else
    {
      Write-Host "$command 软件安装完成"
    }
  } else
  {
    Write-Host "$command 软件已安装"
  }
}

# 使用 npm 安装 Node.js 包
function npm_install($command)
{
  # 检查命令是否已存在
  if (-not (Get-Command -Name $command -ErrorAction SilentlyContinue))
  {
    Write-Host "$command 软件不存在, 开始使用 npm 下载 $command"
    npm install -g $command
    # 检查安装是否成功
    if ($LASTEXITCODE -ne 0)
    {
      Write-Host "npm install -g $command 失败，请检查网络或手动安装。" -ForegroundColor Red
    } else
    {
      Write-Host "$command 软件安装完成"
    }
  } else
  {
    Write-Host "$command 软件已安装"
  }
}

# 配置 PSCompletions
function PSCompletions_config
{
  # 检查 PSCompletions 模块是否已安装
  if (Get-Module -Name PSCompletions -ListAvailable)
  {
    Write-Host "配置 PSCompletions..."
    # 获取已有的补全源
    $existing_completions = PSCompletions list
    # 需要添加的补全源列表
    $completions_to_add = @("npm", "pip", "cargo", "scoop", "git")

    foreach ($completion in $completions_to_add)
    {
      # 检查补全源是否已存在
      if ($existing_completions -notmatch $completion)
      {
        PSCompletions add $completion
        Write-Host "$completion 补全源已添加"
      } else
      {
        Write-Host "$completion 补全源已存在"
      }
    }
  }
}


# --- 主执行流程 ---


# 4. 安装 PowerShell 主题和模块
catppuccin

# 5. 安装 Python 和 Node.js 包
pip_install "compiledb"
npm_install "@google/gemini-cli"

# 6. 配置补全
PSCompletions_config

# 7. 构建 bat 缓存
bat cache --build

Write-Host "安装完成"
