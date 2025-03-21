# 引入 PSFzf
Import-Module PSFzf

Set-PsFzfOption -TabExpansion
Set-PsFzfOption -EnableAliasFuzzyHistory -EnableAliasFuzzyKillProcess -EnableAliasFuzzySetLocation -EnableAliasFuzzyScoop  -EnableAliasFuzzyZLocation -EnableAliasFuzzyGitStatus.

# psfzf
Set-PsFzfOption -PSReadLineChordProvider ‘Ctrl+f’ -PSReadLineChordReverseHistory ‘Ctrl+r’
# fzf
# $Env:FZF_DEFAULT_COMMAND = 'fd --hidden --follow 
# -E ".git" 
# -E "node_modules" 
# -E ".cache" '
# fzf
$Env:FZF_DEFAULT_COMMAND = 'fd --type f' 
$Env:FZF_CTRL_R_OPTS="--height 40% --preview 'echo {}' --reverse"
$Env:FZF_ALT_C_OPTS="--preview 'eza --classify --color-scale --icons=always --group-directories-first --long {}'"
$Env:FZF_DEFAULT_OPTS = '--height 90% 
--tmux 80% 
--bind "ctrl-r:change-list-label( Reloading the list )+reload(sleep 2; git ls-files)" 
--layout=reverse 
--bind=alt-j:down,alt-k:up,alt-i:toggle+down 
--bind=ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up
--bind="ctrl-e:execute:nvim {}"
--preview "bat --paging=always --color=always --style=numbers --line-range=:500 {}" 
--highlight-line 
--info=inline-right 
--ansi 
--layout=reverse 
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
--color=pointer:#c0caf5
--color=prompt:#65bcff
--color=query:#c8d3f5:regular
--color=scrollbar:#589ed7
--color=separator:#a9b1d6
--color=spinner:#ff007c
--color=preview-border:#a9b1d6
--multi
--marker=" " --pointer="> " --separator="─" --scrollbar="│"
--border-label-pos="0" --preview-window="border-rounded" --padding="1,2" --prompt="> "
'
$Env:_ZO_FZF_OPTS   ='--height 90% 
--tmux 80% 
--layout=reverse 
--highlight-line 
--preview "eza --classify --color-scale --icons=always --group-directories-first --long  {2}"
--info=inline-right 
--ansi 
--layout=reverse 
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
--color=pointer:#c0caf5
--color=prompt:#65bcff
--color=query:#c8d3f5:regular
--color=scrollbar:#589ed7
--color=separator:#a9b1d6
--color=spinner:#ff007c
--color=preview-border:#a9b1d6
'

