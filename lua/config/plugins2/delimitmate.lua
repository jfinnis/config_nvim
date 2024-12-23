--
-- delimitMate - automatically close brackets
--

return {
    'Raimondi/delimitMate',
    config = function()
        vim.g.delimitMate_expand_cr = 1
        vim.g.delimitMate_expand_space = 1
        vim.g.delimitMate_excluded_ft = 'TelescopePrompt'
    end
}
