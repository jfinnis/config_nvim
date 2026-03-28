vim.keymap.set('n', '<space>tl', ':PlenaryBustedFile %<cr>',
    { desc = '[<space>] [T]est current [l]ua file' })

return {
    {
        -- local development - advent of code example plugin
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

    {
        -- dir = '~/Documents/projects/ansi.nvim',
        'jfinnis/ansi.nvim',
        config = function()
            require('ansi').setup({
                auto_enable = false,  -- Auto-enable for configured filetypes
                filetypes = { 'log', 'ansi' },  -- Filetypes to auto-enable
                -- Color theme: 'classic', 'modern', 'catppuccin', 'dracula', 'onedark', 'gruvbox', 'terminal'
                theme = 'terminal',
            })
        end,
    },
}
