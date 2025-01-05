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

            -- configure the language servers
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- lua
            local lspconfig = require('lspconfig')
            lspconfig.lua_ls.setup { capabilities = capabilities }

            -- typescript
            lspconfig.ts_ls.setup {}

            -- biome.js linter/formatter
            lspconfig.biome.setup {}

            -- gleam
            lspconfig.gleam.setup {}

            -- json
            lspconfig.jsonls.setup {
                settings = {
                    json = {
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true }
                    }
                }
            }

            -- yaml
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

            -- create LSP mappings
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP Actions',
                callback = function(event)
                    local telescope = require('telescope.builtin')
                    nmap('gK', function()
                        telescope.lsp_definitions({ show_line = true })
                    end, event, '[G]oto [K] definition')
                    nmap('<leader>fd', function()
                        telescope.diagnostics(require('telescope.themes').get_ivy{})
                    end, event, '[;f] Show [D]iagnostics')
                    nmap('gy', function()
                        telescope.lsp_document_symbols({
                            prompt_title = 'LSP Symbols (C-l to filter)',
                            show_line = true
                        })
                    end, event, '[G]oto LSP S[y]mbols') -- default gO

                    -- pretty hover (with transparent window)
                    vim.cmd[[ hi NormalFloat guifg=#e6eaea guibg=NONE ]]
                    vim.keymap.set('n', 'K', ":lua require('pretty_hover').hover()<cr>",
                        { desc ='[K] Show Info in Hover', silent = true })

                    ---- use trouble references instead
                    -- vim.keymap.set('n', 'g/', vim.lsp.buf.references) -- default grr

                    nmap('gd', function()
                        vim.diagnostic.open_float({ border = 'rounded' })
                    end, event, '[G]oto Current Line [D]iagnostics') -- default <C-W>d
                    nmap('gt', require('telescope.builtin').lsp_type_definitions,
                        event, '[G]oto [T]ype of Element')
                    vim.keymap.set('i', '<tab><space>', vim.lsp.buf.signature_help,
                        { buffer = event.buf, desc = '[i_<tab><space>] Show function signature' }) -- default <C-S>

                    -- set formatting command in ftplugin instead
                    -- nmap('<tab><space>', ':lua vim.lsp.buf.format({ async = true })<cr>',
                    --    event, '[<tab><space>] Format the entire file')

                    -- TODO: remove when updated and these become defaults (current in nightly)
                    nmap('grn', vim.lsp.buf.rename,
                        { buffer = event.buf, desc = '[g] [R]e[n]ame' })
                    nmap('gra', vim.lsp.buf.code_action,
                        { buffer = event.buf, desc = '[gr] Code [a]ction' })
                    nmap('gi', vim.lsp.buf.implementation,
                        { buffer = event.buf, desc = '[G]oto [I]mplementation' }) -- default gri
                end
            })
        end,
    },

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
}
