$basePath = Get-Item "$Home/.config/chezmoi" -ErrorAction SilentlyContinue
if (-not $basePath)
{
  $basePath = New-Item -ItemType Directory -Path "$Home/.config/chezmoi"
}
Get-Item $Home/OneDrive/.config/chezmoi/chezmoi.toml | ForEach-Object {
  $linkPath = Join-Path $basePath $_.Name
  if (Test-Path $linkPath)
  {
    Remove-Item -Path $linkPath -Force
  }
  New-Item -ItemType HardLink -Path $linkPath -Target $_.FullName
}
