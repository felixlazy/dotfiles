$basePath = Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'PowerShell'
Get-Item $Home/.config/pwsh/Microsoft.PowerShell_profile.ps1 | ForEach-Object {
  $linkPath = Join-Path $basePath $_.Name
  if (Test-Path $linkPath)
  {
    Remove-Item -Path $linkPath -Force
  }
  New-Item -ItemType HardLink -Path $linkPath -Target $_.FullName
}
