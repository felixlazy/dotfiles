# Mihomo Windows 初始化脚本

$ConfigDir = "$HOME\.config\mihomo"
if (!(Test-Path $ConfigDir)) { New-Item -ItemType Directory -Path $ConfigDir -Force }

# 1. 尝试通过 Scoop 安装 mihomo
if (!(Get-Command mihomo -ErrorAction SilentlyContinue)) {
    Write-Host "Mihomo 未安装，尝试通过 Scoop 安装..."
    if (Get-Command scoop -ErrorAction SilentlyContinue) {
        scoop install mihomo
    } else {
        Write-Warning "未找到 Scoop，请手动安装 Mihomo 并将其加入 PATH。"
    }
}

# 2. Windows 后台运行说明
# Windows 比较麻烦，通常有几种做法：
# A. 使用任务计划程序 (Task Scheduler) 开机静默启动
# B. 使用 NSSM 将其注册为服务
# 这里提供一个简单的任务计划程序创建脚本：

$TaskName = "Mihomo-Daemon"
$Binary = Get-Command mihomo -ErrorAction SilentlyContinue
if ($Binary) {
    $BinaryPath = $Binary.Source
    $Action = New-ScheduledTaskAction -Execute $BinaryPath -Argument "-d $ConfigDir"
    $Trigger = New-ScheduledTaskTrigger -AtLogOn
    $Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
    
    # 如果任务不存在则创建
    if (!(Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue)) {
        Register-ScheduledTask -Action $Action -Trigger $Trigger -Settings $Settings -TaskName $TaskName -Description "Mihomo Proxy Daemon"
        Write-Host "已创建 Windows 任务计划：开机自动启动 Mihomo。"
    }
}
