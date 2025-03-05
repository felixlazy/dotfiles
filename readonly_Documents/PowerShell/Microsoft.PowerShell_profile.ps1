Import-Module posh-git
Import-Module PSCompletions

Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# 环境变量设置
$Env:XDG_CONFIG_HOME=$Env:home+"\.config"
$Env:XDG_DATA_HOME  =$Env:home+"\.local\share"
$Env:XDG_STATE_HOME =$Env:home+"\.local\share"
$Env:NVIM_LOG_FILE  =$Env:home+"\.local\share"
$Env:_ZO_DATA_DIR   =$Env:home+"\.local\share\zoxide"
$Env:path += ";$Env:home/.config/fzf"
$Env:YAZI_CONFIG_HOME=$Env:home+"\.config\yazi"
$Env:scoop=$Env:home+"\scoop"
$Env:EZA_CONFIG_DIR = $Env:XDG_CONFIG_HOME+"\eza"
$Env:EDITOR='nvim'
$Env:RUNEWIDTH_EASTASIAN=0

#设置代理
$Env:http_proxy="http://127.0.0.1:7890"
$Env:https_proxy="http://127.0.0.1:7890"

. "$Env:XDG_CONFIG_HOME\fzf\PSFzf.ps1"
. "$Env:XDG_CONFIG_HOME\pwsh\PSReadLine.ps1"
. "$Env:XDG_CONFIG_HOME\pwsh\Eza.ps1"
. "$Env:XDG_CONFIG_HOME\pwsh\Bind.ps1"
. "$Env:XDG_CONFIG_HOME\pwsh\Onefetch.ps1"
fastfetch
