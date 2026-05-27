# Stop mihomo to unlock Country.mmdb on Windows
# This script runs before chezmoi applies changes.

Get-Process mihomo -ErrorAction SilentlyContinue | Stop-Process -Force
Write-Host "Mihomo process stopped to allow file updates."
