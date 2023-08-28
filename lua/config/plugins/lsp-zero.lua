--
-- lsp-zero settings
--   combines several plugins with reasonable defaults
--

-- TODO: look into mason
--require('mason.settings').set({
--    ui = {
--        border = 'double'
--    }
--})

local lsp = require('lsp-zero').preset({
    name = 'recommended',
    float_border = 'double',
    set_lsp_keymaps = {
        preserve_mappings = true,
        omit = {}
    },
    -- nvim-cmp is responsible for autocompletion
    manage_nvim_cmp = true,
})

lsp.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
})

local nmap = function(keys, func, desc)
    if desc then
        desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, {buffer = bufnr, desc = desc})
end

lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({buffer = bufnr})
    vim.keymap.set('v', '=', vim.lsp.buf.format, {desc = 'LSP: Format the selected text'})

    -- use gs gr is used for replace mode, so reuse gs instead
    nmap('gs', require('telescope.builtin').lsp_references, '[G] [S]earch references to symbol')
    nmap('gK', vim.lsp.buf.definition, '[G]oto [K] definition')
    nmap('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype of Element')
    nmap('g=', vim.lsp.buf.format, '[G=] Format Whole File')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[;] Show [C]ode [A]ctions')
    nmap('<leader>cr', vim.lsp.buf.rename, '[;c] [R]ename Symbol Under Cursor')
end)

local lspconfig = require('lspconfig')

--
-- lua
--
--lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

--
-- json
--
lspconfig.jsonls.setup{
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = {enable = true}
        }
    }
}

--
-- yaml
--
lspconfig.yamlls.setup{
    settings = {
        yaml = {
            schemaStore = {
                -- You must disable built-in schemaStore support if you want to use
                -- this plugin and its advanced options like `ignore`.
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
            },
            schemas = require('schemastore').yaml.schemas()
        }
    }
}

--
-- typescript
--
lspconfig.tsserver.setup{
}


--
-- emmet
--
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.emmet_ls.setup{
    -- on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {'css', 'html', 'javascript', 'javascriptreact', 'scss', 'typescriptreact'},
    init_options = {
        html = {
            options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                ['output.selfClosingStyle'] = 'xhtml',
                ['bem.enabled'] = true,
            },
        },
        jsx = {
            options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                ['output.selfClosingStyle'] = 'xhtml',
                ['bem.enabled'] = true,
            },
        },
    }
}

lsp.setup()

-- TODO: telescope code stuff
--nmap('<leader>cs', require('telescope.builtin').lsp_document_symbols, '[;] [C]ode [S]ymbols') -- TODO: what do these od
--nmap('<leader>cw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[;] [C]ode [S]ymbols')

-- need to override LSP-Zero keymap after lsp.setup has been called
vim.keymap.set('n', 'gd', vim.diagnostic.open_float, {desc = 'LSP: [G] Current Line [D]iagnostics'})
