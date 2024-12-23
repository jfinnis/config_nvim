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

local lspconfig = require('lspconfig')

--
-- lua
--
--lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

--
-- gleam
--
lspconfig.gleam.setup({})

--
-- json
--
lspconfig.jsonls.setup{
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true }
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
lspconfig.ts_ls.setup{
}

lsp.setup()



--TODO: try onsails/lspkind to add in lsp window icons
