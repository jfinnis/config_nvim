-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.maplocalleader = ' '

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- Load plugin directory - each file installs itself
        { import = 'config.plugins2' },

        -- codeium - free ai assistant
        {
            'Exafunction/codeium.vim',
            event = 'BufEnter',
            config = function() require('config.plugins.codeium') end
        },

        -- fidget - eye candy for nvim-lsp language progress
        { 'j-hui/fidget.nvim' },

        -- lsp-zero - good setup for lsp
        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v4.x',
            lazy = true,
            config = function() require('config.plugins.lsp-zero') end
        },
        {
            'williamboman/mason.nvim',
            lazy = false,
            opts = {},
        },

        -- Autocompletion
        {
            'hrsh7th/nvim-cmp',
            event = 'InsertEnter',
            config = function()
                local cmp = require('cmp')

                cmp.setup({
                    sources = {
                        {name = 'nvim_lsp'},
                    },
                    mapping = cmp.mapping.preset.insert({
                        ['<C-Space>'] = cmp.mapping.complete(),
                        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    }),
                    snippet = {
                        expand = function(args)
                            vim.snippet.expand(args.body)
                        end,
                    },
                })
            end
        },

        -- LSP
        {
            'neovim/nvim-lspconfig',
            cmd = {'LspInfo', 'LspInstall', 'LspStart'},
            event = {'BufReadPre', 'BufNewFile'},
            dependencies = {
                {'hrsh7th/cmp-nvim-lsp'},
                {'williamboman/mason.nvim'},
                {'williamboman/mason-lspconfig.nvim'},
            },
            init = function()
                -- Reserve a space in the gutter
                -- This will avoid an annoying layout shift in the screen
                vim.opt.signcolumn = 'yes'
            end,
            config = function() require('config.plugins.lspconfig') end
        },

        -- pretty_hover - clean up lsp dialogs
        {
            'Fildo7525/pretty_hover',
            event = 'LspAttach',
            config = function() require('config.plugins.prettyhover') end
        },
    },

    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- check plugin updates but don't notify
    checker = { enabled = true, notify = false },
    -- don't reload config on changes
    change_detection = { enabled = false, notify = false },
}, {
    rocks = {
        hererocks = true,
    },
})

require('lazy').setup('plugins', {
    change_detection = {
        notify = false,
    },
})
