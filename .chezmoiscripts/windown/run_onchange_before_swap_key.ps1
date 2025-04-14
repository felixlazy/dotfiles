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

# 创建一个哈希表来存储扫描码映射
$scancodeMap = @(
  0x00, 0x00, 0x00, 0x00, # Header
  0x00, 0x00, 0x00, 0x00, # Header
  0x05, 0x00, 0x00, 0x00, # Number of entries (including null terminator)
  0x1D, 0x00, 0x3A, 0x00, # Caps Lock -> Ctrl
  0x00, 0x00, 0x00, 0x00  # Null terminator
)

# 将扫描码映射转换为字节数组
$scancodeMapBytes = [byte[]]$scancodeMap

# 设置注册表项
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout"
$registryName = "Scancode Map"
Set-ItemProperty -Path $registryPath -Name $registryName -Value $scancodeMapBytes

Write-Output "Scancode map has been set. Please restart your computer for the changes to take effect."
