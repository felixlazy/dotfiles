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

# 设置 .ahk 脚本或 .exe 路径
$ahkScriptPath = Get-Item $Home/.config/autohotkey/.ahk  # 修改为你的 .ahk 文件路径
# 或者使用编译后的 .exe
#$ahkScriptPath = "C:\path\to\your\script.exe"  # 修改为你的 .exe 文件路径

# 设置注册表路径（用于启动项）
$regKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
$regName = "MyScript"  # 给你的程序命名

# 向注册表添加启动项
Set-ItemProperty -Path $regKey -Name $regName -Value $ahkScriptPath

Write-Host "The registry has been successfully updated, and the program will start at system startup"
