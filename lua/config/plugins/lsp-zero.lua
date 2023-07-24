--
-- lsp-zero
--

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    vim.keymap.set('n', 'gs', 'gr')
    -- TODO:    :help lsp-zero-keybindings to make this work
    -- TODO: make todo stand out in bold
end)

local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())


lsp.setup()
