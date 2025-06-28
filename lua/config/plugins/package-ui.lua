--
-- package-ui
--

return {
    'MonsieurTib/package-ui.nvim',
    config = function()
        require('package-ui').setup()
        vim.keymap.set('n', '<localleader>pu', '<cmd>PackageUI<cr>', { desc = '[<space>] Open [P]ackage [U]I' })
    end,
}
