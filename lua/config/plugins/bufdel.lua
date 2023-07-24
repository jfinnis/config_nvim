require('bufdel').setup {
  next = 'tabs',
  quit = true,  -- quit Neovim when last buffer is closed
}

vim.keymap.set('n', '<leader>q', ':bd<cr>')
vim.keymap.set('n', '<leader>Q', ':BufDel!<cr>')
vim.keymap.set('n', '<leader>bo', ':BufDelOthers!<cr>')
