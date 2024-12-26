vim.cmd("hi Visual gui=reverse")
vim.cmd("highlight CursorLine gui=NONE guibg=bg")
-- vim.cmd("highlight Cursor gui=NONE guifg=bg guibg=#ffb6c1")
-- add additional keyword chars
vim.cmd([[autocmd FileType org setlocal iskeyword+=:,#,+]])
