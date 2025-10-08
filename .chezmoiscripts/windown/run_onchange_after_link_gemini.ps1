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

# 确保目标目录存在
$geminiDir = Join-Path $HOME ".gemini"
if (-not (Test-Path $geminiDir))
{
  New-Item -Path $geminiDir -ItemType Directory -Force | Out-Null
}

# 定义源文件和链接文件的路径
$sourceDir = Join-Path $HOME ".config\gemini"
$filesToLink = @("settings.json","GEMINI.md")

foreach ($file in $filesToLink)
{
  $sourceFile = Join-Path $sourceDir $file
  $linkFile = Join-Path $geminiDir $file
    
  # 如果源文件存在，则创建符号链接并覆盖现有文件
  if (Test-Path $sourceFile)
  {
    New-Item -ItemType SymbolicLink -Path $linkFile -Target $sourceFile -Force | Out-Null
  }
}
