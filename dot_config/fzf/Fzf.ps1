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

Function c()
{
  $Columns = [int]((get-host).ui.rawui.WindowSize.Width / 3)
  $Separator ='{::}'
  $History = "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\History"
  $TempFile = New-TemporaryFile
  $Query = "select substr(title, 1, $Columns), url from urls order by last_visit_time desc"
  Copy-Item $History -Destination $TempFile
  @(sqlite3 -separator "$Separator" "$TempFile" "$Query") |
    ForEach-Object {
      $Title, $Url = ($_ -split $Separator)[0, 1]
      "$($Title.PadRight($Columns))  `e[36m$Url`e[0m"
    } | fzf --ansi --multi --no-preview | ForEach-Object{start-process "chrome.exe" ($_ -replace '.*(https*://)', '$1'),'--profile-directory="Default"'}
}

Function e()
{
  $Columns = [int]((get-host).ui.rawui.WindowSize.Width / 3)
  $Separator ='{::}'
  $History = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\History"
  $TempFile = New-TemporaryFile
  $Query = "select substr(title, 1, $Columns), url from urls order by last_visit_time desc"
  Copy-Item $History -Destination $TempFile
  @(sqlite3 -separator "$Separator" "$TempFile" "$Query") |
    ForEach-Object {
      $Title, $Url = ($_ -split $Separator)[0, 1]
      "$($Title.PadRight($Columns))  `e[36m$Url`e[0m"
    } | fzf --ansi --multi --no-preview | ForEach-Object{start-process "msedge.exe" ($_ -replace '.*(https*://)', '$1'),'--profile-directory="Default"'}
}
# b - browse chrome bookmarks
Function b()
{
  $Bookmarks = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Bookmarks"

  $JqScript=@'
     def ancestors: while(. | length >= 2; del(.[-1,-2]));
     . as $in | paths(.url?) as $key | $in | getpath($key) | {name,url, path: [$key[0:-2] | ancestors as $a | $in | getpath($a) | .name?] | reverse | join("/") } | .path + "/" + .name + "|" + .url
'@

  Get-Content "$Bookmarks" | jq -r "$JqScript" `
  | ForEach-Object {
    $_ -replace "(.*)\|(.*)", "`$1`t`e[36m`$2`e[0m"
  } `
  | fzf --ansi `
  | ForEach-Object {
    start-process "chrome.exe" ($_ -split "`t")[1],'--profile-directory="Default"'
  }
}

# be - browse edge bookmarks
Function be()
{
  $Bookmarks = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Bookmarks"

  $JqScript=@'
     def ancestors: while(. | length >= 2; del(.[-1,-2]));
     . as $in | paths(.url?) as $key | $in | getpath($key) | {name,url, path: [$key[0:-2] | ancestors as $a | $in | getpath($a) | .name?] | reverse | join("/") } | .path + "/" + .name + "|" + .url
'@

  Get-Content "$Bookmarks" | jq -r "$JqScript" `
  | ForEach-Object {
    $_ -replace "(.*)\|(.*)", "`$1`t`e[36m`$2`e[0m"
  } `
  | fzf --ansi `
  | ForEach-Object {
    start-process "msedge.exe" ($_ -split "`t")[1],'--profile-directory="Default"'
  }
}
function grl
{
  git reflog --pretty='%h %gs' | 
    fzf --ansi --no-sort --preview "git show -p --stat --pretty=fuller --color=always {1} | delta"
}
function glo
{
  git log --pretty=format:'%C(yellow)%h %Cgreen%ad %Cblue%an%Creset %s' --date=short |
    fzf --ansi --no-sort --preview="git show --color=always {1} | delta" --bind "enter:execute:git show {1} | delta | less -R"
}
function gd
{
  git diff --name-only | fzf --ansi `
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

# t - 搜索并切换到当前打开的浏览器标签页
function t()
{
  $port = 9222
  $endpoint = "http://127.0.0.1:$port/json/list"
  $activate_endpoint_base = "http://127.0.0.1:$port/json/activate"

  try
  {
    # 获取所有打开的标签页列表
    $tabs = Invoke-RestMethod -Uri $endpoint -ErrorAction Stop
  } catch
  {
    Write-Error "无法连接到浏览器的调试端口 $port。"
    Write-Error "请确认您已关闭所有浏览器实例，并使用 '--remote-debugging-port=$port' 参数重新启动了浏览器。"
    Write-Error "例如: start chrome --remote-debugging-port=$port"
    return
  }

  if (-not $tabs)
  {
    Write-Output "没有找到打开的标签页。"
    return
  }

  # 将标签页列表格式化后传递给 fzf
  # 我们使用制表符 `t 分隔 标题、URL 和一个隐藏的 ID
  # fzf 会搜索标题和 URL，但返回整行，我们再从中提取 ID
  $selectedTabLine = $tabs | Where-Object { $_.type -eq 'page' } | ForEach-Object {
    # 确保标题和 URL 中没有制表符，以防破坏格式
    $title = $_.title -replace "`t", " "
    $url = $_.url -replace "`t", " "
    $id = $_.id
    "$title`t`e[36m$url`e[0m`t$id"
  } | fzf --ansi --with-nth='1,2' --delimiter="`t" --preview 'echo {2}'

  # 如果用户选中了一个标签页 (没有按 Esc 退出)
  if ($selectedTabLine)
  {
    # 从返回的行中提取第三个字段，即标签页的 ID
    $tabId = ($selectedTabLine -split "`t")[2]
    $activateUrl = "$activate_endpoint_base/$tabId"

    try
    {
      # 发送请求以激活（切换到）选中的标签页
      Invoke-RestMethod -Uri $activateUrl -ErrorAction Stop
    } catch
    {
      Write-Error "激活标签页失败。无法访问: $activateUrl"
    }
  }
}


