function ex
{
  explorer.exe . 
}

function tve
{
  nvim $(tv)
}

Set-alias lg lazygit
Set-alias 'sudo' 'gsudo'
Set-alias 'fz' '__zoxide_zi'
Set-Alias make 'make -j$(nproc)'

function p
{
  scoop $args
}
   
function pai
{
  param(
    [Parameter(Mandatory=$true, ValueFromRemainingArguments=$true)]
    [string[]]$Packages
  )
  scoop install $Packages
}
   
function par
{
  param(
    [Parameter(Mandatory=$true, ValueFromRemainingArguments=$true)]
    [string[]]$Packages
  )
  scoop uninstall $Packages
}
   
function pas
{
  param(
    [Parameter(Mandatory=$true, ValueFromRemainingArguments=$true)]
    [string[]]$Query
  )
  scoop search $Query
}
   
function pal
{
  scoop list $args
}
   
function paf
{
  param(
    [Parameter(Mandatory=$true, ValueFromRemainingArguments=$true)]
    [string[]]$Package
  )
  scoop info $Package
}
   
function pao
{
  param(
    [Parameter(Mandatory=$true, ValueFromRemainingArguments=$true)]
    [string[]]$Command
  )
  scoop which $Command
}

# yzai
function y
{
  $tmp = [System.IO.Path]::GetTempFileName()
  yazi $args --cwd-file="$tmp"
  $cwd = Get-Content -Path $tmp
  if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path)
  {
    Set-Location -LiteralPath $cwd
  }
  Remove-Item -Path $tmp
}
function mpvc
{
  param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Files
  )
  mpv --autofit=80%x80% --geometry=50%:50% @Files
}
