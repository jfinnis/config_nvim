vim.keymap.set('n', '<space>tl', ':PlenaryBustedFile %<cr>',
    { desc = '[<space>] [T]est current [l]ua file' })

return {
    {
        -- teej_dv advent of code example plugin

        -- local development
        -- dir = '~/Documents/projects/present.nvim',

        -- working git repo
        'jfinnis/present.nvim',
    }
}
