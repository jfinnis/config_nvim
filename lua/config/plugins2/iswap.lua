--
-- iswap.nvim - swap text objects
--

return {
    'mizlan/iswap.nvim',
    event = 'VeryLazy',
    config = function()
        require('iswap').setup{
            flash_style = 'simultaneous',
            move_cursor = true,
        }

        vim.keymap.set('n', '<a', ':ISwapWithLeft<cr>',
            { desc = '[<a] Swap arg/param to the left', silent = true })
        vim.keymap.set('n', '>a', ':ISwapWithRight<cr>',
            { desc = '[>a] Swap arg/param to the right', silent = true })
    end
}
