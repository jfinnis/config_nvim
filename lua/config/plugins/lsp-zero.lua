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

    local telescope = require('telescope.builtin')
    nmap('g/', function()
        telescope.lsp_references({
            show_line = true,
            trim_text = true
        })
    end, '[g/] Search references to symbol')
    nmap('gK', function()
        telescope.lsp_definitions({
            show_line = true
        })
    end, '[G]oto [K] definition')
    nmap('gy', function()
        telescope.lsp_document_symbols({
            prompt_title = 'LSP Symbols (C-l to filter)',
            show_line = true
        })
    end, '[G]oto LSP S[y]mbols')
    nmap('<leader>fd', function()
        telescope.diagnostics(require('telescope.themes').get_ivy{})
    end, '[;f] Show [D]iagnostics')
    nmap('gt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype of Element')
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
    filetypes = {'css', 'scss', 'html', 'javascript', 'javascriptreact', 'scss', 'typescriptreact'},
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

-- need to override LSP-Zero keymap after lsp.setup has been called
vim.keymap.set('n', 'gd', vim.diagnostic.open_float, {desc = '[G]oto Current Line [D]iagnostics'})

-- try to do a cloudformation experimental lsp TODO
--vim.cmd [[
--    let g:LanguageClient_serverCommands = { 'cfn.yaml': ['~/.local/bin/cfn-lsp-extra'], 'cfn.json': ['~/.local/bin/cfn-lsp-extra'] }
--]]
--
--
--TODO: try onsails/lspkind to add in lsp window icons
