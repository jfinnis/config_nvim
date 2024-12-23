return {
    'briangwaltney/paren-hint.nvim',
    lazy = false,
    config = function()
        require('paren-hint').setup({
            include_paren = false, -- Include the opening paren in the ghost text

            -- excluded filetypes
            excluded_filetypes = {
                'lspinfo',
                'packer',
                'checkhealth',
                'help',
                'man',
                'gitcommit',
                'TelescopePrompt',
                'TelescopeResults',
                '',
            },
            -- excluded buftypes
            excluded_buftypes = {
                'terminal',
                'nofile',
                'quickfix',
                'prompt',
            },
        })
    end,
}
