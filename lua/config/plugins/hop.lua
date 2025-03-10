--
-- hop - easymotion replacement
--

return {
    'smoka7/hop.nvim',
    version = "*",
    config = function()
        require'hop'.setup()

        -- move to character
        vim.keymap.set('n', 'H', ':HopChar1MW<cr>')

        -- move to line
        vim.keymap.set('n', 'L', ':HopLineStartMW<cr>')
    end
}
