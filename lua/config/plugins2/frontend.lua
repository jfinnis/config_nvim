return {
    {
        -- live-server
        'barrett-ruth/live-server.nvim',
        config = function()
            require('live-server').setup({ })

            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'html,css,js,ts,jsx,tsx',
                callback = function()
                    vim.keymap.set('n', '<space>l', ':LiveServerStart<cr>',
                        { desc = '[<space>] Run [L]ive Server', buffer = true })
                end
            })
        end
    },

    -- tagalong - match open/ending html tags when changing with 'c'
    { 'AndrewRadev/tagalong.vim' },
}
