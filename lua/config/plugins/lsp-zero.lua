--
-- lsp-zero
--

local lsp = require('lsp-zero').preset({})
lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    -- TODO:    :help lsp-zero-keybindings to make this work
    -- TODO: make todo stand out in bold
end)

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

lspconfig.jsonls.setup {
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = {enable = true}
        }
    }
}

lspconfig.yamlls.setup {
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.emmet_ls.setup({
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
})

lsp.setup()

-- gr is used for replace mode, so reuse gs instead
vim.keymap.set('n', 'gs', ':lua vim.lsp.buf.references()<cr>')
