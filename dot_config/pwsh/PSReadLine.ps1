
# 引入 ps-read-line
Import-Module PSReadLine

# Import the catppuccin
Import-Module Catppuccin

# Set a flavor for easy access
$Flavor = $Catppuccin['Mocha']

# 设置预测文本来源为历史记录
Set-PSReadLineOption -PredictionSource History
# # 每次回溯输入历史，光标定位于输入内容末尾
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
# # 设置 Tab 为菜单补全和 Intellisense
#Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete
Set-PSReadLineKeyHandler -Key "Ctrl+p" -Function HistorySearchBackward # 设置向上键为后向搜索历史记录
Set-PSReadLineKeyHandler -Key "Ctrl+n" -Function HistorySearchForward # 设置向下键为前向搜索历史纪录
Set-PSReadLineKeyHandler -Key "Ctrl+u" -Function BackwardDeleteInput # 删除到开头
Set-PSReadLineKeyHandler -Chord '"',"'" `
  -BriefDescription SmartInsertQuote `
  -LongDescription "Insert paired quotes if not already on a quote" `
  -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($line.Length -gt $cursor -and $line[$cursor] -eq $key.KeyChar)
  {
    # Just move the cursor
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
  } else
  {
    # Insert matching quotes, move cursor to be in between the quotes
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)" * 2)
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor - 1)
  }
}
Set-PSReadLineKeyHandler -Key '(','{','[' `
  -BriefDescription InsertPairedBraces `
  -LongDescription "Insert matching braces" `
  -ScriptBlock {
  param($key, $arg)

  $closeChar = switch ($key.KeyChar)
  {
    <#case#> '('
    { [char]')'; break 
    }
    <#case#> '{'
    { [char]'}'; break 
    }
    <#case#> '['
    { [char]']'; break 
    }
  }

  $selectionStart = $null
  $selectionLength = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($selectionStart -ne -1)
  {
    # Text is selected, wrap it in brackets
    [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $key.KeyChar + $line.SubString($selectionStart, $selectionLength) + $closeChar)
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
  } else
  {
    # No text is selected, insert a pair
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)$closeChar")
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
  }
}

Set-PSReadLineKeyHandler -Key ')',']','}' `
  -BriefDescription SmartCloseBraces `
  -LongDescription "Insert closing brace or skip" `
  -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($line[$cursor] -eq $key.KeyChar)
  {
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
  } else
  {
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)")
  }
}

Set-PSReadLineKeyHandler -Key Backspace `
  -BriefDescription SmartBackspace `
  -LongDescription "Delete previous character or matching quotes/parens/braces" `
  -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($cursor -gt 0)
  {
    $toMatch = $null
    if ($cursor -lt $line.Length)
    {
      switch ($line[$cursor])
      {
        <#case#> '"'
        { $toMatch = '"'; break 
        }
        <#case#> "'"
        { $toMatch = "'"; break 
        }
        <#case#> ')'
        { $toMatch = '('; break 
        }
        <#case#> ']'
        { $toMatch = '['; break 
        }
        <#case#> '}'
        { $toMatch = '{'; break 
        }
      }
    }

    if ($toMatch -ne $null -and $line[$cursor-1] -eq $toMatch)
    {
      [Microsoft.PowerShell.PSConsoleReadLine]::Delete($cursor - 1, 2)
    } else
    {
      [Microsoft.PowerShell.PSConsoleReadLine]::BackwardDeleteChar($key, $arg)
    }
  }
}

$Colors = @{
  # Largely based on the Code Editor style guide
  # Emphasis, ListPrediction and ListPredictionSelected are inspired by the Catppuccin fzf theme
	
  # Powershell colours
  ContinuationPrompt     = $Flavor.Teal.Foreground()
  Emphasis               = $Flavor.Red.Foreground()
  Selection              = $Flavor.Surface0.Background()
	
  # PSReadLine prediction colours
  InlinePrediction       = $Flavor.Overlay0.Foreground()
  ListPrediction         = $Flavor.Mauve.Foreground()
  ListPredictionSelected = $Flavor.Surface0.Background()

  # Syntax highlighting
  Command                = $Flavor.Blue.Foreground()
  Comment                = $Flavor.Overlay0.Foreground()
  Default                = $Flavor.Text.Foreground()
  Error                  = $Flavor.Red.Foreground()
  Keyword                = $Flavor.Mauve.Foreground()
  Member                 = $Flavor.Rosewater.Foreground()
  Number                 = $Flavor.Peach.Foreground()
  Operator               = $Flavor.Sky.Foreground()
  Parameter              = $Flavor.Pink.Foreground()
  String                 = $Flavor.Green.Foreground()
  Type                   = $Flavor.Yellow.Foreground()
  Variable               = $Flavor.Lavender.Foreground()
}

# Set the colours
Set-PSReadLineOption -Colors $Colors

