--
-- all LSP configuration
--

return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'saghen/blink.cmp',
            {
                'folke/lazydev.nvim',
                ft = 'lua', -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                    },
                },
            },
        },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            require('lspconfig').lua_ls.setup { capabilities = capabilities }

            -- vim.keymap.set('n', 'g/', vim.lsp.buf.references) -- default grr
            ---- use trouble version instead
            vim.keymap.set('n', 'gd', vim.diagnostic.open_float,
                { desc = '[G]oto Current Line [D]iagnostics' }) -- default <C-W>d
            vim.keymap.set('n', '<tab><space>', ':lua vim.lsp.buf.format()<cr>',
                { desc = '[<tab><space>] Format the entire file' })
            vim.keymap.set('i', '<tab><space>', vim.lsp.buf.signature_help,
                { desc = '[i_<tab><space>] Show function signature' }) -- default <C-S>

            -- TODO: remove when updated and these become defaults
            -- these mappings are defaults in the nightly version of Neovim
            vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
            vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
            vim.keymap.set('n', 'gri', vim.lsp.buf.implementation)
            vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol)
        end,
        init = function()
            -- Reserve a space in the gutter to avoid an annoying layout shift in the screen.
            vim.opt.signcolumn = 'yes'
        end,
    },
}
