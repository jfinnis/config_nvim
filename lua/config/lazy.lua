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
        -- import your plugins
        -- { import = "config/plugins" },

        -- autosave
        {
            'pocco81/auto-save.nvim',
            config = function() require('config.plugins.autosave') end
        },

        -- buffer close commands
        {
            'ojroques/nvim-bufdel',
            config = function() require('config.plugins.bufdel') end
        },

        -- color schemes
        {
            'rose-pine/neovim',
            name = 'rose-pine',
            config = function() require('config.plugins.rose-pine') end
        },
        { 'EdenEast/nightfox.nvim' },

        -- codeium - free ai assistant
        {
            'Exafunction/codeium.vim',
            event = 'BufEnter',
            config = function() require('config.plugins.codeium') end
        },
        --
        -- comment - comment management
        {
            'numToStr/Comment.nvim',
            config = function() require('config.plugins.comment') end
        },

        -- delimitMate - automatically close brackets
        {
            'Raimondi/delimitMate',
            config = function() require('config.plugins.delimitmate') end
        },

        -- emmet - emmet completion in html-like files
        { 'aca/emmet-ls' },

        -- fidget - eye candy for nvim-lsp language progress
        { 'j-hui/fidget.nvim' },

        -- fugitive
        {
            'tpope/vim-fugitive',
            config = function() require('config.plugins.fugitive') end
        },
        -- fubitive - allow bitbucket for Git Browse
        { 'tommcdo/vim-fubitive' },

        -- gitsigns - git file status in the signs, show/hide diffs
        {
            'lewis6991/gitsigns.nvim',
            config = function() require('config.plugins.gitsigns') end
        },

        -- glow - preview markdown in neovim
        {
            'ellisonleao/glow.nvim',
            cmd = 'Glow',
            config = function() require('config.plugins.glow') end
        },

        -- hexokinase - color indicator for html/css/etc
        {
            'RRethy/vim-hexokinase',
            build = 'make hexokinase',
            config = function() require('config.plugins.hexokinase') end
        },

        -- hop - easymotion replacement
        {
            'smoka7/hop.nvim',
            version = "*",
            config = function() require('config.plugins.hop') end
        },

        -- indent-blankline - show fancy indent guidelines
        {
            'lukas-reineke/indent-blankline.nvim',
            main = 'ibl',
            ---@module 'ibl'
            ---@type ibl.config
            opts = {},
        },

        -- lsp-signature - show function signatures while editing
        {
            'ray-x/lsp_signature.nvim',
            event = 'VeryLazy',
            config = function() require('config.plugins.lsp-signature') end
        },

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

        -- lualine - fancy statusline
        {
            'nvim-lualine/lualine.nvim',
            dependencies = {
                'nvim-tree/nvim-web-devicons',
                opt = true
            },
            config = function() require('config.plugins.lualine') end
        },

        -- marks - show marks in sign column
        {
            'chentoast/marks.nvim',
            event = 'VeryLazy',
            config = function() require('config.plugins.marks') end
        },

        -- matchup - advanced matching pairs with %
        { 'andymass/vim-matchup' },

        -- operator-replace - R{motion} replaces with current register
        {
            'kana/vim-operator-replace',
            dependencies = { {'kana/vim-operator-user'} },
            config = function() require('config.plugins.operator-replace') end
        },

        -- neorg - orgmode for neovim
        {
            'nvim-neorg/neorg',
            lazy = false,
            dependencies = { 'nvim-treesitter' },
            version = "*",
            config = function() require('config.plugins.neorg') end
        },

        -- pretty_hover - clean up lsp dialogs
        {
            'Fildo7525/pretty_hover',
            event = 'LspAttach',
            config = function() require('config.plugins.prettyhover') end
        },

        -- rainbow parens
        {
            'hiphish/rainbow-delimiters.nvim',
            config = function() require('config.plugins.rainbow') end
        },

        -- regexplainer - show help info for regexes
        {
            'ArjunSahlot/nvim-regexplainer',
            -- this fork fixes a bug with errors showing in temporary buffers like Trouble
            -- 'bennypowers/nvim-regexplainer',
            dependencies = {
                'nvim-treesitter/nvim-treesitter',
                'MunifTanjim/nui.nvim'
            },
            config = function() require('config.plugins.regexplainer') end
        },

        -- repeat - extend '.' repetition to plugins like surround
        { 'tpope/vim-repeat' },

        -- schemastore - catalog of json schemas to check against
        { 'b0o/schemastore.nvim' },

        -- sleuth - detect shift/tabwidth based upon the current file
        { 'tpope/vim-sleuth' },

        -- surround - control surrounding quotes, brackets, html tags, etc
        { 'tpope/vim-surround' },

        -- switch - toggle common cyclical words (true -> false -> true)
        {
            'AndrewRadev/switch.vim',
            config = function() require('config.plugins.switch') end
        },

        -- tagalong - match open/ending html tags when changing with 'c'
        { 'AndrewRadev/tagalong.vim' },

        -- telescope - fuzzy finder
        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.8',
            dependencies = { {'nvim-lua/plenary.nvim'} },
            config = function() require('config.plugins.telescope') end
        },

        -- telescope - faster search
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },

        -- telescope - alternate file mappings
        {
            'otavioschwanck/telescope-alternate',
            config = function() require('config.plugins.telescope-alternate') end
        },

        -- telescope - docker integration
        {
            'lpoto/telescope-docker.nvim',
            config = function() require('config.plugins.telescope-docker') end
        },

        -- telescope - file browser
        {
            'nvim-telescope/telescope-file-browser.nvim',
            dependencies = {'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim'},
            config = function() require('config.plugins.telescope-file-browser') end
        },

        -- telescope - neoclip yank history
        {
            'AckslD/nvim-neoclip.lua',
            dependencies = {
                {'nvim-telescope/telescope.nvim'}
            },
            config = function() require('config.plugins.telescope-neoclip') end
        },

        -- web-icons
        {
            'nvim-tree/nvim-web-devicons'
        },

        -- todo comment highlighter
        {
            'folke/todo-comments.nvim',
            dependencies = { "nvim-lua/plenary.nvim" },
            config = function() require('config.plugins.todo-comments') end
        },

        -- treesitter - syntax parser
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            config = function() require('config.plugins.treesitter') end
        },
        -- treesitter - always show function context as top line
        {
            'nvim-treesitter/nvim-treesitter-context',
            config = function() require('config.plugins.treesitter-context') end
        },
        -- treesitter - text objects
        {
            'nvim-treesitter/nvim-treesitter-textobjects',
            dependencies = 'nvim-treesitter/nvim-treesitter',
            config = function() require('config.plugins.treesitter-textobjects') end
        },

        -- trouble - pretty quickfix/notices/diagnostics
        {
            'folke/trouble.nvim',
            dependencies = 'nvim-tree/nvim-web-devicons',
            config = function() require('config.plugins.trouble') end
        },

        -- twilight - dim inactive parts of file
        {
            'folke/twilight.nvim',
            config = function() require('config.plugins.twilight') end
        },

        -- undotree - view history of changes
        {
            'mbbill/undotree',
            config = function() require('config.plugins.undotree') end
        },

        -- unimpaired - navigation functions for the ] and [ keys
        -- forked repo to override some mappings
        { 'jfinnis/vim-unimpaired' },

        -- zen mode - focus on current buffer only
        {
            'folke/zen-mode.nvim',
            config = function() require('config.plugins.zenmode') end
        },
    },

    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})