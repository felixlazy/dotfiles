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
# 设置注册表键路径
$registryPath = "HKCU:\Software\Policies\Microsoft\Edge"

# 如果注册表键不存在，则创建它
if (-not (Test-Path $registryPath))
{
  New-Item -Path $registryPath -Force
}

# 设置注册表值
try
{
  Set-ItemProperty -Path $registryPath -Name "ConfigureKeyboardShortcuts" -Value '{"disabled": ["new_window"]}'
  Write-Output "Registry value has been set successfully."
} catch
{
  Write-Error "Error setting registry value: $_"
}
