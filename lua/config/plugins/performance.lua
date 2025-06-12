--
-- faster.nvim - speed up for large files or large macros
-- garbage-day.nvim - pause LSP when Neovim is inactive
--

return {
    {
        'pteroctopus/faster.nvim'
    },
    {
        'zeioth/garbage-day.nvim',
        enabled = false,
        dependencies = 'neovim/nvim-lspconfig',
        event = 'VeryLazy',
        opts = {
            -- your options here
        }
    },
}
