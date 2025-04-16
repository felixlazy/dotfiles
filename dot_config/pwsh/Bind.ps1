function ex
{
  explorer.exe . 
}
function fe
{
  nvim $(fzf)
}

function tve
{
  nvim $(tv)
}

Set-alias lg lazygit
Set-alias 'sudo' 'gsudo'
Set-alias 'fz' '__zoxide_zi'
function ai
{
  nvim -c "terminal aichat"
}
function gw
{
  glazewm start --config "C:\Users\felix\.config/glazewm/glazewm.yaml"
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
