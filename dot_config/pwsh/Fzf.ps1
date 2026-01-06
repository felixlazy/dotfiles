# 引入 PSFzf
Import-Module PSFzf

Set-PsFzfOption -TabExpansion
Set-PsFzfOption -EnableAliasFuzzyHistory -EnableAliasFuzzyKillProcess -EnableAliasFuzzySetLocation -EnableAliasFuzzyScoop  -EnableAliasFuzzyZLocation -EnableAliasFuzzyGitStatus.

# psfzf
Set-PsFzfOption -PSReadLineChordProvider ‘Ctrl+f’ -PSReadLineChordReverseHistory ‘Ctrl+r’

# --- FZF Configuration ---

# Default command
$Env:FZF_DEFAULT_COMMAND = 'fd --type f'

# Options for history (Ctrl+R)
$Env:FZF_CTRL_R_OPTS="--height 40% --preview 'echo {}' --reverse"

# Options for directory change (Alt+C)
$Env:FZF_ALT_C_OPTS="--preview 'eza --classify --color-scale --icons=always --group-directories-first --long {}'"

# Common core fzf styling options to avoid duplication (without multi-select or specific marker/pointer)
$FzfCoreStyleOpts = "
--style=full
--input-label=Input
--layout=reverse
--ansi
--border=none
--multi
--marker=' '
--pointer=' '
--scrollbar='│'
--border-label-pos='0'
--preview-window='border-rounded'
--padding='1,2'
--prompt='> '
--layout=reverse
--highlight-line
--info=inline-right
--ansi
--border=none
--color=bg+:#414868
--color=bg:#222436
--color=border:#589ed7
--color=fg:#8db0ff
--color=fg+:#8db0ff
--color=gutter:#222436
--color=header:#ff966c
--color=hl+:#f7768e
--color=hl:#f7768e
--color=info:#545c7e
--color=marker:#9ece6a
--color=pointer:#8db0ff
--color=prompt:#65bcff
--color=query:#c8d3f5:regular
--color=scrollbar:#589ed7
--color=separator:#a9b1d6
--color=spinner:#ff007c
--color=preview-border:#a9b1d6
--color=border:#8db0ff
--color=label:#8db0ff
--color=preview-border:#8db0ff
--color=preview-label:#8db0ff
--color=list-border:#8db0ff
--color=list-label:#8db0ff
--color=input-border:#ff966c
--color=input-label:#ff966c
--color=header-border:#8db0ff
--color=header-label:#8db0ff
"

# Default options for fzf (includes multi-select and detailed visual options)
$Env:FZF_DEFAULT_OPTS = "
--height 90%
--tmux 80%
$FzfCoreStyleOpts
--bind='ctrl-a:beginning-of-line'
--bind=alt-j:down,alt-k:up,alt-i:toggle+down
--bind=ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up
--bind=""ctrl-e:execute:nvim {}""
--preview=""bat --paging=always --color=always --style=numbers --line-range=:500 {}""
--preview-window=right:60%
"

# Options for zoxide (z) - does not explicitly add multi-select
$Env:_ZO_FZF_OPTS   = "
--height 90%
--tmux 80%
$FzfCoreStyleOpts
--preview=""eza --classify --color-scale --icons=always --group-directories-first --long {2}""
"

function grl
{
  git reflog --pretty='%h %gs' | 
    fzf  --multi --no-sort --preview "git show -p --stat --pretty=fuller --color=always {1} | delta"
}
function glo
{
  git log --pretty=format:'%C(yellow)%h %Cgreen%ad %Cblue%an%Creset %s' --date=short |
    fzf  --multi --no-sort --preview="git show --color=always {1} | delta" --bind "enter:execute:git show {1} | delta | less -R"
}
function gd
{
  git diff --name-only | fzf  --multi `
    --preview 'git diff --color=always {} | delta' `
    --bind 'enter:execute(nvim {})'
}
function fenv
{
  Get-ChildItem Env: | ForEach-Object { "$($_.Name)=$($_.Value)" } | 
    fzf --preview 'powershell -c "echo $env:{1}"'
}

function fe
{
  nvim $(fzf)
}

