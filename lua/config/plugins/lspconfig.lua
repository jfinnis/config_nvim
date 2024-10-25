--
-- lspconfig settings
--

local lsp_defaults = require('lspconfig').util.default_config

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

-- mapper helper
local nmap = function(keys, func, event, desc)
    if desc then
        desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, {buffer = event.buf, desc = desc})
end

-- LspAttach is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = {buffer = event.buf}
        local telescope = require('telescope.builtin')

        vim.keymap.set('v', '=', vim.lsp.buf.format, {buffer = event.buf, desc = 'LSP: Format the selected text'})

        nmap('K', '<cmd>lua vim.lsp.buf.hover()<cr>', event, '[K] Show Info in Hover')
        vim.keymap.set({'n', 'x'}, 'g=', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', {buffer = event.buf, desc = 'LSP: [G=] Format Whole File'})

        nmap('gK', function()
            telescope.lsp_definitions({ show_line = true })
        end, event, '[G]oto [K] definition')

        -- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        -- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        -- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        -- vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

        nmap('gt', require('telescope.builtin').lsp_type_definitions, event, '[G]oto [T]ype of Element')

        nmap('<leader>fd', function()
            telescope.diagnostics(require('telescope.themes').get_ivy{})
        end, event, '[;f] Show [D]iagnostics')

        nmap('gy', function()
            telescope.lsp_document_symbols({
                prompt_title = 'LSP Symbols (C-l to filter)',
                show_line = true
            })
        end, event, '[G]oto LSP S[y]mbols')

        nmap('<leader>ca', vim.lsp.buf.code_action, event, '[;] Show [C]ode [A]ctions')
        nmap('<leader>cr', vim.lsp.buf.rename, event, '[;c] [R]ename Symbol Under Cursor')

        -- Show floating window of function signature when editing
        require 'lsp_signature'.on_attach({
            bind = true,
            handler_opts = {
                border = 'double'
            },
        }, event.buf)
    end,
})

-- need to override LSP-Zero keymap after lsp.setup has been called
vim.keymap.set('n', 'gd', vim.diagnostic.open_float, {desc = '[G]oto Current Line [D]iagnostics'})

require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
        -- this first function is the "default handler"
        -- it applies to every language server without a "custom handler"
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    }
})
