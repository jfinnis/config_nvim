--
-- lsp
-- nvim-lspconfig, mason, tiny-code-action, better-type-hover, nvim-java
--

local nmap = function(keys, func, event, desc)
    if desc then
        desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
end

return {
    -- provides server configs for lsps
    {
        'neovim/nvim-lspconfig',
        config = function()
            -- Reserve a space in the gutter to avoid an annoying layout shift in the screen.
            vim.opt.signcolumn = 'yes'

            vim.lsp.enable({
                'biome',
                'jdtls',
                'jsonls',
                'lua_ls',
                'taplo',
                'trivy',
                'ts_ls',
                'yamlls',
            })

            -- typescript/javascript - inline hints off by default, toggle with grh
            local inlay_hints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            }
            vim.lsp.config('ts_ls', {
                settings = {
                    typescript = {
                        inlayHints = inlay_hints
                    },
                    javascript = {
                        inlayHints = inlay_hints
                    }
                }
            })

            -- configs
            vim.lsp.config('jsonls', {
                settings = {
                    json = {
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true }
                    }
                }
            })
            vim.lsp.config('yamlls', {
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
                    -- diagnostics only shown in sign column by default so show in
                    -- text and lines
                    vim.diagnostic.config({
                        severity_sort = true,
                        virtual_text = {
                            severity = {
                                vim.diagnostic.severity.WARN,
                                vim.diagnostic.severity.INFO,
                                vim.diagnostic.severity.HINT,
                                vim.diagnostic.severity.ERROR,
                            },
                        },
                    })

                    -- replaced by built-in <c-]> ?
                    --nmap('gK', function()
                    --    telescope.lsp_definitions({ show_line = true })
                    --end, event, '[G]oto [K] definition')

                    --nmap('g<m-k>', function()
                    --    telescope.lsp_definitions({ show_line = true, jump_type = 'vsplit' })
                    --end, event, '[G]oto [K] definition (vert split)')

                    local telescope = require('telescope.builtin')
                    nmap('gt', telescope.lsp_type_definitions,
                        event, '[G]oto [T]ype of Element')

                    nmap('<leader>fd', function()
                        telescope.diagnostics(require('telescope.themes').get_ivy {})
                    end, event, '[;] [F]ind [D]iagnostics')

                    nmap('gd', function()
                        vim.diagnostic.open_float({ border = 'rounded' })
                    end, event, '[G]oto Current Line [D]iagnostics') -- default <C-W>d

                    nmap('gy', function()
                        telescope.lsp_document_symbols({
                            prompt_title = 'LSP Symbols (C-l to filter)',
                            show_line = true
                        })
                    end, event, '[G]oto LSP Symb[o]ls') -- default gO

                    -- toggle inlay hints
                    vim.keymap.set('n', 'grh', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                    end, { buffer = event.buf, desc = '[gr] Toggle inlay [h]ints' }) -- default <C-S>

                    -- override default code action 'gra'
                    vim.keymap.set({ 'n', 'x' }, 'gra', function()
                        require('tiny-code-action').code_action()
                    end, { noremap = true, silent = true })

                    -- use built-in <C-S>
                    --vim.keymap.set('i', '<tab><space>', vim.lsp.buf.signature_help,
                    --    { buffer = event.buf, desc = '[i_<tab><space>] Show function signature' })
                end
            })
        end
    },

    -- java lsp helper
    {
        'nvim-java/nvim-java',
        -- config = function() require('java').setup {} end
    },

    -- manages lsp install/updates
    {
        'mason-org/mason.nvim',
        opts = {},
        config = function()
            require('mason').setup {
                -- socket.dev proxy check packages
                firewall = {
                    enabled = true
                }
            }
        end
    },

    -- nested type info in the K hover of typescript types
    {
        'Sebastian-Nielsen/better-type-hover',

        -- overridden to customize falling back to pretty_hover K when needed
        -- no longer using pretty_hover
        -- 'jfinnis/better-type-hover',

        config = function()
            require('better-type-hover').setup({
                openTypeDocKeymap = 'K'
            })
        end
    },

    -- cleaner code actions window
    {
        'rachartier/tiny-code-action.nvim',
        dependencies = {
            {'nvim-lua/plenary.nvim'},
            -- optional picker via telescope
            {'nvim-telescope/telescope.nvim'},
        },
        event = 'LspAttach',
        opts = {
            backend = 'delta', -- vim, delta, difftastic, diffsofancy
            picker = 'telescope', -- telescope | snacks | select | buffer
            telescope = {}
        }
    }
}
