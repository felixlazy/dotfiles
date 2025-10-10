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
