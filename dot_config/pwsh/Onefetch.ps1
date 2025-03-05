$global:lastRepository = $null
function Check-DirectoryForNewRepository
{
  $currentRepository = git rev-parse --show-toplevel 2>$null
  if ($currentRepository -and ($currentRepository -ne $global:lastRepository))
  {
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    onefetch | Write-Host
  }
  $global:lastRepository = $currentRepository
}

function Set-Location
{
  param (
    [string]$Path,
    [string]$LiteralPath
  )

  if ($LiteralPath)
  {
    Microsoft.PowerShell.Management\Set-Location -LiteralPath $LiteralPath
  } else
  {
    Microsoft.PowerShell.Management\Set-Location -Path $Path
  }

  Check-DirectoryForNewRepository
}

Check-DirectoryForNewRepository

