vim.keymap.set('n', '<space>tl', ':PlenaryBustedFile %<cr>',
    { desc = '[<space>] [T]est current [l]ua file' })

return {
    {
        -- teej_dv advent of code example plugin

        -- local development
        -- dir = '~/Documents/projects/present.nvim',

        -- working git repo
        'jfinnis/present.nvim',
    },

    {
        -- dir = '~/Documents/projects/spotify-notification.nvim',
        'jfinnis/spotify-notification.nvim',
        opts = {
            debug = false
        },
    },

    {
        -- dir = '~/Documents/projects/CloudWatch-query.nvim',
        'jfinnis/CloudWatch-query.nvim',
    },
}
