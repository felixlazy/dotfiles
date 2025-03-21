export FZF_DEFAULT_OPTS="\
  --tmux 80% \
  --preview 'fzf-preview.sh {}' \
  --bind 'ctrl-r:change-list-label( Reloading the list )+reload(sleep 2; git ls-files)' \
  --bind=ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#414868 \
  --color=bg:#222436 \
  --color=border:#589ed7 \
  --color=fg:#8db0ff \
  --color=fg+:#8db0ff \
  --color=gutter:#222436 \
  --color=header:#ff966c \
  --color=hl+:#f7768e \
  --color=hl:#f7768e \
  --color=info:#545c7e \
  --color=marker:#9ece6a \
  --color=pointer:#c0caf5 \
  --color=prompt:#65bcff \
  --color=query:#c8d3f5:regular \
  --color=scrollbar:#589ed7 \
  --color=separator:#a9b1d6 \
  --color=spinner:#ff007c \
  --color=preview-border:#a9b1d6 \
  --multi \
  --marker=' ' --pointer='> ' --separator='─' --scrollbar='│' \
  --border-label-pos='0' --preview-window='border-rounded' --padding='1,2' --prompt='> ' \
  "
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_ALT_C_OPTS="--preview 'eza --classify --color-scale --icons=always --group-directories-first --long {}'"
export _ZO_FZF_OPTS="\
  --tmux 80% \
  --preview 'eza --classify --color-scale --icons=always --group-directories-first --long {2}' \
  --bind 'ctrl-r:change-list-label( Reloading the list )+reload(sleep 2; git ls-files)' \
  --bind=ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#414868 \
  --color=bg:#222436 \
  --color=border:#589ed7 \
  --color=fg:#8db0ff \
  --color=fg+:#8db0ff \
  --color=gutter:#222436 \
  --color=header:#ff966c \
  --color=hl+:#f7768e \
  --color=hl:#f7768e \
  --color=info:#545c7e \
  --color=marker:#9ece6a \
  --color=pointer:#c0caf5 \
  --color=prompt:#65bcff \
  --color=query:#c8d3f5:regular \
  --color=scrollbar:#589ed7 \
  --color=separator:#a9b1d6 \
  --color=spinner:#ff007c \
  --color=preview-border:#a9b1d6 \
  --multi \
  --marker=' ' --pointer='> ' --separator='─' --scrollbar='│' \
  --border-label-pos='0' --preview-window='border-rounded' --padding='1,2' --prompt='> ' \
  "
# 使用 fzf 选择文件并在 nvim 中打开选定的结果
fe() {
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0 --preview="bat --color=always {}"))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}
# brew 搜索并安装软件
fs() {
  local token
  token=$(brew search --casks "$1" | fzf-tmux --query="$1" +m --preview 'brew info {}')

  if [ "x$token" != "x" ]                                                                
  then             
    echo "(I)nstall or open the (h)omepage of $token"
    read input                             
    if [ $input = "i" ] || [ $input = "I" ]; then    
      brew install --cask $token                   
    fi                                                                                    
    if [ $input = "h" ] || [ $input = "H" ]; then                                         
      brew home $token                     
    fi                                           
  fi                             
}                                              
# Uninstall or open the webpage for the selected application 
# using brew list as input source (all brew cask installed applications) 
# and display a info quickview window for the currently marked application
fus() {                                                                     
  local token                                                                   
  token=$(brew list --casks | fzf-tmux --query="$1" +m --preview 'brew info {}')

  if [ "x$token" != "x" ]                                                       
  then                                                                          
    echo "(U)ninstall or open the (h)omepae of $token"                        
    read input                                                                
    if [ $input = "u" ] || [ $input = "U" ]; then                             
      brew uninstall --cask $token                                          
    fi                                                                        
    if [ $input = "h" ] || [ $token = "h" ]; then                             
      brew home $token                                                      
    fi                                                                        
  fi                                                                            
}                                                                                 
# Modified version where you can press
tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}
# zsh; needs setopt re_match_pcre. You can, of course, adapt it to your own shell easily.
tmuxkillf () {
  local sessions
  sessions="$(tmux ls|fzf --exit-0 --multi)"  || return $?
  local i
  for i in "${(f@)sessions}"
  do
    [[ $i =~ '([^:]*):.*' ]] && {
      echo "Killing $match[1]"
          tmux kill-session -t "$match[1]"
        }
      done
    }
