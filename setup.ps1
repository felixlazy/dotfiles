Write-Host "开始安装需要的软件"
function install($command)
{
  if ( !(Get-Command -Name $command -ErrorAction SilentlyContinue) )
  {
    do
    { 
      Write-Host $command
      Write-Host "$command 软件不存在,开始下载$command"
      scoop install $command 
    }while(!$?)
  } else
  {
    Write-Host "$command 软件安装完成"
  }
}
function catppuccin()
{ 
  Import-Module Catppuccin
  if (!$?)
  {
    git clone https://github.com/catppuccin/powershell.git $env:scoop//modules//catppuccin
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
  $module = Get-Module -Name  PSCompletions -ListAvailable
  if ($module)
  {
    PSCompletions add npm
    PSCompletions add pip
    PSCompletions add cargo
    PSCompletions add scoop
    PSCompletions add git
  }
}
install( "windows-terminal" )
install( "pwsh" )
install( "7zip" )
install( "aria2" )
install( "bat" )
install( "bottom" )
install( "chezmoi" )
install( "delta" )
install( "everything" )
install( "eza" )
install( "fastfetch" )
install( "fd" )
install( "ffmpeg" )
install( "fzf" )
install( "gcc-arm-none-eabi" )
install( "gdu" )
install( "geekuninstaller" )
install( "gh" )
install( "git" )
install( "github" )
install( "glow" )
install( "gsudo" )
install( "gzip" )
install( "hexyl" )
install( "lazygit" )
install( "lua" )
install( "mingw" )
install( "neovide" )
install( "neovim" )
install( "nodejs" )
install( "poppler" )
install( "posh-git" )
install( "potplayer" )
install( "psfzf" )
install( "python" )
install( "ripgrep" )
install( "rustup" )
install( "starship" )
install( "vscode" )
install( "wezterm" )
install( "yazi" )
install( "zoxide" )
install( "psreadline" )
install( "flow-launcher" )
install( "pandoc" )
install( "glazewm" )
catppuccin
pip_install( "compiledb" )
npm_install( "fanyi" )
npm_install( "taskbook" )
import_module( "PSCompletions" )
PSCompletions_config
Write-Host "安装完成"
