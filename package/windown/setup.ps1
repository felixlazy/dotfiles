Write-Host "开始安装需要的软件"
function install_scoop
{
  if (-not (Get-Command scoop -ErrorAction SilentlyContinue))
  {
    Write-Host "scoop 未安装，开始安装 scoop"
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
    scoop bucket add extras
    scoop bucket add main
  } else
  {
    Write-Host "scoop 已安装"
  }
}
function catppuccin()
{ 
  if (-not (Get-Module -ListAvailable -Name Catppuccin)) 
  {
    git clone https://github.com/catppuccin/powershell.git $env:scoop/modules/catppuccin
    Import-Module $env:scoop/modules/catppuccin/Catppuccin.psm1
  } else 
  {
    Import-Module Catppuccin
  }
}
function pip_install($command)
{
  if ( !(Get-Command -Name $command -ErrorAction SilentlyContinue) )
  {
    do
    { 
      Write-Host $command
      Write-Host "$command 软件不存在,开始下载$command"
      pip install $command 
    }while(!$?)
  } else
  {
    Write-Host "$command 软件安装完成"
  }
}
function npm_install($command)
{
  if ( !(Get-Command -Name $command -ErrorAction SilentlyContinue) )
  {
    do
    { 
      Write-Host $command
      Write-Host "$command 软件不存在,开始下载$command"
      npm install -g $command 
    }while(!$?)
  } else
  {
    Write-Host "$command 软件安装完成"
  }
}
function import_module($command)
{
  $module = Get-Module -Name $command -ListAvailable
  if (!$module)
  {
    Install-Module $command -Scope CurrentUser
  } 
}
function PSCompletions_config
{
  $module = Get-Module -Name PSCompletions -ListAvailable
  if ($module)
  {
    $completions = @("npm", "pip", "cargo", "scoop", "git")
    foreach ($completion in $completions)
    {
      if (-not (PSCompletions list | Select-String -Pattern $completion))
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
function install_scoop_packages($packages)
{
  foreach ($package in $packages)
  {
    $installedPackage = scoop list | Select-String -Pattern $package
    if (-not $installedPackage -or $installedPackage -match "failed")
    {
      Write-Host "$package 下载失败或未安装，重新下载..."
      scoop install $package
      if ($LASTEXITCODE -ne 0)
      {
        Write-Host "$package 下载失败，重新下载..."
        scoop install $package
      } else
      {
        Write-Host "$package 已安装"
      }
    } else
    {
      Write-Host "$package 已存在"
    }
  }
}
scoop bucket add extras
scoop bucket add main
install_scoop_packages("aria2")
$packages=@(
  "7zip",
  "aria2",
  "bat",
  "bottom",
  "chezmoi",
  "dark",
  "delta",
  "everything",
  "eza",
  "fastfetch",
  "fd",
  "ffmpeg",
  "flow-launcher",
  "fzf",
  "gcc-arm-none-eabi",
  "geekuninstaller",
  "gh",
  "git",
  "github",
  "glow",
  "gsudo",
  "gzip",
  "hexyl",
  "imagemagick",
  "innounp",
  "jq",
  "lazygit",
  "lua",
  "mingw",
  "neovide",
  "neovim",
  "nodejs",
  "obsidian",
  "onefetch",
  "pandoc",
  "poppler",
  "posh-git",
  "potplayer",
  "psfzf",
  "psreadline",
  "pwsh",
  "python",
  "ripgrep",
  "rust-analyzer",
  "rustup",
  "starship",
  "television",
  "vscode",
  "wechat",
  "wezterm",
  "windows-terminal",
  "yazi",
  "zoxide"
)
install_scoop_packages $packages
catppuccin
pip_install( "compiledb" )
npm_install( "fanyi" )
import_module( "PSCompletions" )
PSCompletions_config
Write-Host "安装完成"
