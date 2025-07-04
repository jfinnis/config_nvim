--
-- all LSP configuration
-- lspconfig + mason + pretty_hover
--

local nmap = function(keys, func, event, desc)
    if desc then
        desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
end

-- replicate LSP signs from lsp-zero plugin
local set_sign_icons = function(opts)
    local ds = vim.diagnostic.severity
    local levels = {
        [ds.ERROR] = 'error',
        [ds.WARN] = 'warn',
        [ds.INFO] = 'info',
        [ds.HINT] = 'hint'
    }

    local text = {}
    for i, l in pairs(levels) do
        if type(opts[l]) == 'string' then
            text[i] = opts[l]
        end
    end

    vim.diagnostic.config({signs = { text = text }})
end
set_sign_icons { error = '✘', warn = '▲', hint = '⚑', info = '»' }

return {
    {
        -- java lsp helper
        'nvim-java/nvim-java',
        -- config = function() require('java').setup {} end
    },

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
            -- Reserve a space in the gutter to avoid an annoying layout shift in the screen.
            vim.opt.signcolumn = 'yes'

            -- Set the key K so that Neovim doesn't override it and we can attach later
            vim.keymap.set('n', 'K', '')

            -- TODO: how does this work with new lspconfig update?
            -- configure the language servers
            -- local capabilities = require('blink.cmp').get_lsp_capabilities()
            -- lua
            -- lspconfig.lua_ls.setup { capabilities = capabilities }

            vim.lsp.enable({ 'ts_ls', 'jsonls', 'yamlls', 'lua_ls', 'jdtls', 'gleam', 'biome' })

            -- extra config for languages
            -- json
            vim.lsp.config('jsonls', {
                settings = {
                    json = {
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true }
                    }
                }
            })

            -- yaml
            vim.lsp.config('jsonls', {
                settings = {
                    yaml = {
                        schemas = require('schemastore').yaml.schemas(),
                        validate = { enable = true }
                    }
                }
            })

            -- create LSP mappings
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP Actions',
                callback = function(event)
                    local telescope = require('telescope.builtin')

                    -- diagnostics only shown in sign column by default so show in
                    -- text and lines
                    vim.diagnostic.config({
                        severity_sort = true,
                        virtual_text = {
                            severity = {
                                vim.diagnostic.severity.WARN,
                                vim.diagnostic.severity.INFO,
                                vim.diagnostic.severity.HINT,
                            },
                            -- current_line = false,
                        },
                        virtual_lines = {
                            severity = {
                                vim.diagnostic.severity.ERROR,
                            },
                            -- current_line = true
                        },
                    })

                    -- mappings
                    nmap('gK', function()
                        telescope.lsp_definitions({ show_line = true })
                    end, event, '[G]oto [K] definition')

                    nmap('<leader>fd', function()
                        telescope.diagnostics(require('telescope.themes').get_ivy{})
                    end, event, '[;] [F]ind [D]iagnostics')

                    nmap('gy', function()
                        telescope.lsp_document_symbols({
                            prompt_title = 'LSP Symbols (C-l to filter)',
                            show_line = true
                        })
                    end, event, '[G]oto LSP Symb[o]ls') -- default gO

                    -- NOTE: hover replaced by pretty_hover plugin, called in better-type-hover
                    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = event.buf })
                    -- vim.keymap.set('n', 'K', ":lua require('pretty_hover').hover()<cr>",
                    --     { desc ='[K] Show Info in Hover', silent = true })

                    nmap('gd', function()
                        vim.diagnostic.open_float({ border = 'rounded' })
                    end, event, '[G]oto Current Line [D]iagnostics') -- default <C-W>d

                    nmap('gt', require('telescope.builtin').lsp_type_definitions,
                        event, '[G]oto [T]ype of Element')
                    vim.keymap.set('i', '<tab><space>', vim.lsp.buf.signature_help,
                        { buffer = event.buf, desc = '[i_<tab><space>] Show function signature' }) -- default <C-S>

                    -- NOTE: set formatting command in ftplugin instead
                    -- nmap('<tab><space>', ':lua vim.lsp.buf.format({ async = true })<cr>',
                    --    event, '[<tab><space>] Format the entire file')

                    -- NOTE: use trouble references instead
                    -- vim.keymap.set('n', 'g/', vim.lsp.buf.references) -- default grr

                end
            })
        end,
    },

    -- Mason - just used for checking if there's new versions
    {
        'williamboman/mason.nvim',
        lazy = false,
        opts = {
            ui = {
                border = 'rounded',
            }
        },
    },

    {
        'Fildo7525/pretty_hover',
        event = 'LspAttach',
        opts = {},
    },

    {
        -- overridden to customize falling back to pretty_hover K when needed
        -- dir = '~/Documents/projects/better-type-hover.nvim',
        'jfinnis/better-type-hover',
        -- 'Sebastian-Nielsen/better-type-hover',

        ft = { 'typescript', 'typescriptreact', },
        config = function()
            require('better-type-hover').setup({
                openTypeDocKeymap = 'K'
            })
        end
    },
}
