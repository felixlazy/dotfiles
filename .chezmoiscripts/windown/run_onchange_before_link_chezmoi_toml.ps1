# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator'))
{
  if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000)
  {
    $CommandLine = "-NoExit -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -Wait -FilePath pwsh.exe -Verb Runas -ArgumentList "-NoProfile", $CommandLine
    Exit
  }
}
$path = "C:\Users\felix\.config\chezmoi\chezmoi.toml"
$target = "C:\Users\felix\OneDrive\.config\chezmoi\chezmoi.toml"
$directoryPath = "C:\Users\felix\.config\chezmoi"
if (-Not (Test-Path $directoryPath))
{
  New-Item -ItemType Directory -Path $directoryPath
  Write-Host "Directory created: $directoryPath"
} else
{
  Write-Host "Directory already exists: $directoryPath"
}
if (-Not (Test-Path $path))
{
  New-Item -ItemType SymbolicLink -Path $path -Target $target
} else
{
  Write-Host "$path directory exists"
}
