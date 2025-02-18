function EP
{
  explorer.exe . 
}
function fzf_edite
{
  nvim $(fzf)
}

Set-alias ex EP 
Set-alias lg lazygit
Set-alias 'sudo' 'gsudo'
Set-alias 'Ctrl+f' 'cd "$(fzf)\.."'
Set-alias fe fzf_edite
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
