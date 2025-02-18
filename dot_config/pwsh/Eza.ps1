# eza
function Get-DirectoryContent
{
  eza --classify --color-scale --icons=always --group-directories-first --time-style iso @args
}
set-alias ls Get-DirectoryContent
function Get-DetailedDirectoryContent
{
  Get-DirectoryContent --long @args
}
set-alias ll Get-DetailedDirectoryContent
function Get-GitIgnoredDirectoryContent
{
  Get-DirectoryContent --git-ignore --git --git-repos @args
}
set-alias lsg Get-DetialedGitIgnoredDirectoryContent
function Get-DetialedGitIgnoredDirectoryContent
{
  Get-GitIgnoredDirectoryContent --long @args
}
set-alias llg Get-DetialedGitIgnoredDirectoryContent
