--
-- undotree - view history of changes
--

return {
    'mbbill/undotree',
    config = function()
        vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end
}
