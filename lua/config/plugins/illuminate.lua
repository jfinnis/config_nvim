--
-- illuminate - highlight word under cursor
--

return {
    'rrethy/vim-illuminate',
    event = 'VeryLazy',
    config = function()
        require('illuminate').configure {
            under_cursor = false,
            filetypes_denylist = {
                'fugitive',
                'norg',
            },
        }
    end,
}
