set -x FZF_DEFAULT_COMMAND 'fd --type f'
set -x FZF_ALT_C_OPTS "--preview 'eza --classify --color-scale --icons=always --group-directories-first --long {}'"
set -x _ZO_FZF_OPTS "
  --tmux 80% 
  --preview 'eza --classify --color-scale --icons=always --group-directories-first --long {2}' 
  --bind 'ctrl-r:change-list-label( Reloading the list )+reload(sleep 2; git ls-files)' 
  --bind=ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up 
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
  --marker=' ' --pointer='> ' --separator='─' --scrollbar='│' 
  --border-label-pos='0' --preview-window='border-rounded' --padding='1,2' --prompt='> ' 
"

set -x FZF_DEFAULT_OPTS " 
  --cycle
  --layout=reverse
  --height 60%
  --ansi
  --preview 'bat {}' 
  --preview-window=right:50%
  --bind=ctrl-u:half-page-up,ctrl-d:half-page-down,ctrl-x:jump
  --bind=ctrl-f:preview-page-down,ctrl-b:preview-page-up
  --bind=ctrl-a:beginning-of-line,ctrl-e:end-of-line
  --bind=ctrl-j:down,ctrl-k:up
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
  --marker=' ' --pointer='> ' --separator='─' --scrollbar='│' 
  --border-label-pos='0' --preview-window='border-rounded' --padding='1,2' --prompt='> ' 
"

set fzf_diff_highlighter delta --paging=never --width=20

function fe
    set -l files (fzf)
    if test -n "$files"
        command nvim $files
    end
end
