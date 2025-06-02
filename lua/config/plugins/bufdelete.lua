--
-- bufdel settings
--

return {
    'ojroques/nvim-bufdel',
    config = function()
        require('bufdel').setup {
            next = 'tabs',
            quit = true,  -- quit Neovim when last buffer is closed
        }

        vim.keymap.set('n', '<leader>q', ':bd<cr>',
            { desc = '[;q] Delete buffer + window', silent = true })
        vim.keymap.set('n', '<leader>Q', ':BufDel!<cr>',
            { desc = '[;Q] Delete buffer and keep window', silent = true })
        vim.keymap.set('n', '<leader>bo', ':BufDelOthers!<cr>',
            { desc = '[;] Keep [b]uffer [o]nly', silent = true })
    end
}
