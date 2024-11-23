vim.cmd("hi Visual gui=reverse")
vim.cmd("highlight CursorLine gui=NONE guibg=bg")
vim.cmd("highlight Cursor gui=NONE guifg=bg guibg=#ffb6c1")
vim.cmd("language en_US.utf8")
vim.opt.shellslash = true
vim.g.completion_chain_complete_list = {
  org = {
    { mode = "omni" },
  },
}
-- add additional keyword chars
vim.cmd([[autocmd FileType org setlocal iskeyword+=:,#,+]])
