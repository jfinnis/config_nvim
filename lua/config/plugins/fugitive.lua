--
-- fugitive settings
--

vim.keymap.set('n', '<leader>gB', ':Git blame<cr>', { desc = '[;] [G]it [B]lame All Lines' })
vim.keymap.set('n', '<leader>gs', ':G<cr>', { desc = '[;] [G]it [S]tatus and Staging' })
vim.keymap.set({'n', 'v'}, '<leader>gw', ':GBrowse<cr>', { desc = '[;] [G]it [B]rowse' })
