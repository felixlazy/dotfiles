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
  sudo New-Item -ItemType SymbolicLink -Path $path -Target $target
} else
{
  Write-Host "$path directory exists"
}
