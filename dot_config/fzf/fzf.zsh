export FZF_DEFAULT_OPTS="\
  --style full \
  --tmux 80% \
  --border --padding 1,2 \
  --border-label ' Demo ' --input-label ' Input ' --header-label ' File Type ' \
  --preview 'fzf-preview.sh {}' \
  --bind 'ctrl-r:change-list-label( Reloading the list )+reload(sleep 2; git ls-files)' \
  --color 'border:#aaaaaa,label:#cccccc' \
  --color 'preview-border:#9999cc,preview-label:#ccccff' \
  --color 'list-border:#669966,list-label:#99cc99' \
  --color 'input-border:#996666,input-label:#ffcccc' \
  --color 'header-border:#6699cc,header-label:#99ccff' \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#2d3f76 \
  --color=bg:#1e2030 \
  --color=border:#589ed7 \
  --color=fg:#c8d3f5 \
  --color=gutter:#1e2030 \
  --color=header:#ff966c \
  --color=hl+:#65bcff \
  --color=hl:#65bcff \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#65bcff \
  --color=query:#c8d3f5:regular \
  --color=scrollbar:#589ed7 \
  --color=separator:#ff966c \
  --color=spinner:#ff007c \
  "
export FZF_DEFAULT_COMMAND='fd'
# 使用 fzf 选择文件并在 nvim 中打开选定的结果
fzf_open_in_nvim() {
  local file
  file=$(fzf) && nvim "$file"
}
 alias fe=fzf_open_in_nvim
