--
-- autosave settings
--

return {
    'pocco81/auto-save.nvim',
    config = function()
        -- toggle autosave
        vim.api.nvim_set_keymap('n', '<leader>S', ':ASToggle<CR>', {})
    end
}
