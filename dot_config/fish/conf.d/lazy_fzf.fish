set -x FZF_DEFAULT_COMMAND 'fd --type f'
set -x FZF_ALT_C_OPTS "--preview 'eza --classify --color-scale --icons=always --group-directories-first --long {}'"

# Common styling for fzf to avoid duplication
set fzf_style_opts " \
  --style=full \
  --input-label=Input \
  --layout=reverse \
  --ansi \
  --border=none \
  --multi \
  --marker=' ' \
  --pointer=' ' \
  --scrollbar='│' \
  --border-label-pos='0' \
  --preview-window='border-rounded' \
  --padding='1,2' \
  --prompt='> ' \
  --color=bg+:#414868 \
  --color=bg:#222436 \
  --color=fg:#8db0ff \
  --color=fg+:#8db0ff \
  --color=gutter:#222436 \
  --color=header:#ff966c \
  --color=hl+:#f7768e \
  --color=hl:#f7768e \
  --color=info:#545c7e \
  --color=marker:#9ece6a \
  --color=pointer:#8db0ff \
  --color=prompt:#65bcff \
  --color=query:#c8d3f5:regular \
  --color=scrollbar:#589ed7 \
  --color=separator:#a9b1d6 \
  --color=spinner:#ff007c \
  --color=border:#8db0ff \
  --color=label:#8db0ff \
  --color=preview-border:#8db0ff \
  --color=preview-label:#8db0ff \
  --color=list-border:#8db0ff \
  --color=list-label:#8db0ff \
  --color=input-border:#ff966c \
  --color=input-label:#ff966c \
  --color=header-border:#8db0ff \
  --color=header-label:#8db0ff \
"

# Options for the default fzf command (e.g., in `fe` function)
set -x FZF_DEFAULT_OPTS " \
  $fzf_style_opts \
  --cycle \
  --tmux 80% \
  --height 80% \
  --preview 'bat --color=always {}' \
  --preview-window=right:60% \
  --bind='ctrl-u:half-page-up,ctrl-d:half-page-down,ctrl-x:jump' \
  --bind='ctrl-f:preview-page-down,ctrl-b:preview-page-up' \
  --bind='ctrl-a:beginning-of-line' \
  --bind='ctrl-j:down,ctrl-k:up' \
  --bind='ctrl-e:execute:nvim {}'
"

# Options for zoxide (zo)
set -x _ZO_FZF_OPTS " \
  $fzf_style_opts \
  --tmux 80% \
  --height 80% \
  --preview 'eza --classify --color-scale --icons=always --group-directories-first --long {2}' \
  --bind='ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up' \
  --highlight-line \
  --info=inline-right \
"

set fzf_diff_highlighter delta --paging=never --width=20

function fe
    set -l files (fzf)
    if test -n "$files"
        command nvim $files
    end
end

fzf_configure_bindings \
    --directory=\ct \
    --git_log=\cg \
    --git_status=\cs \
    --history=\cr \
    --processes=\cp \
    --variables=
