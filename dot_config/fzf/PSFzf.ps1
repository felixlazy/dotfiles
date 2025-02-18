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
$Env:FZF_DEFAULT_COMMAND = 'fd' 
$Env:FZF_DEFAULT_OPTS = '--height 90% 
--style full 
--tmux 80% 
--border --padding 1,2 
--border-label " FZF " --input-label " Input " --header-label " File Type " 
--bind "ctrl-r:change-list-label( Reloading the list )+reload(sleep 2; git ls-files)" 
--color "border:#aaaaaa,label:#cccccc" 
--color "preview-border:#9999cc,preview-label:#ccccff" 
--color "list-border:#669966,list-label:#99cc99" 
--color "input-border:#996666,input-label:#ffcccc" 
--color "header-border:#6699cc,header-label:#99ccff" 
--layout=reverse 
--bind=alt-j:down,alt-k:up,alt-i:toggle+down 
--preview "bat --color=always --style=numbers --line-range=:500 {}" 
--highlight-line 
--info=inline-right 
--ansi 
--layout=reverse 
--border=none
--color=bg+:#2d3f76
--color=bg:#1e2030
--color=border:#589ed7
--color=fg:#c8d3f5
--color=gutter:#1e2030
--color=header:#ff966c
--color=hl+:#65bcff
--color=hl:#65bcff
--color=info:#545c7e
--color=marker:#ff007c
--color=pointer:#ff007c
--color=prompt:#65bcff
--color=query:#c8d3f5:regular
--color=scrollbar:#589ed7
--color=separator:#ff966c
--color=spinner:#ff007c
--multi
'
