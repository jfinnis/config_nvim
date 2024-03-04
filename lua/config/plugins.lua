--
-- plugins.lua
--

-- install packer if not installed on this machine
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

-- first time startup
local packer_bootstrap = ensure_packer()

-- autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
   augroup packer_user_config
   autocmd!
   autocmd BufWritePost plugins.lua source <afile> | PackerSync
   augroup end
]])

return require('packer').startup(function(use)
    -- vim plugin package manager
    use 'wbthomason/packer.nvim'

    -- autosave
    use {
        'pocco81/auto-save.nvim',
        config = function() require('config.plugins.autosave') end
    }

    -- buffer close commands
    use {
        'ojroques/nvim-bufdel',
        config = function() require('config.plugins.bufdel') end
    }

    -- color schemes
    use {
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function() require('config.plugins.rose-pine') end
    }
    use 'EdenEast/nightfox.nvim'

    -- codeium - free ai assistant
    use {
        'Exafunction/codeium.vim',
        requires = {
            'nvim-lua/plenary.nvim',
            'hrsh7th/nvim-cmp'
        },
        config = function() require('config.plugins.codeium') end
    }

    -- comment - comment management
    use {
        'numToStr/Comment.nvim',
        config = function() require('config.plugins.comment') end
    }

    -- delimitMate - automatically close brackets
    use {
        'Raimondi/delimitMate',
        config = function() require('config.plugins.delimitmate') end
    }

    -- emmet - emmet completion in html-like files
    use 'aca/emmet-ls'

    -- fidget - eye candy for nvim-lsp language progress
    -- pinned to legacy while it is being rewritten
    use 'j-hui/fidget.nvim'

    -- fugitive
    use {
        'tpope/vim-fugitive',
        config = function() require('config.plugins.fugitive') end
    }
    -- fubitive - allow bitbucket for Git Browse
    use {
        'tommcdo/vim-fubitive'
    }

    -- gitsigns - git file status in the signs, show/hide diffs
    use {
        'lewis6991/gitsigns.nvim',
        config = function() require('config.plugins.gitsigns') end
    }

    -- glow - preview markdown in neovim
    use {
        'ellisonleao/glow.nvim',
        config = function() require('config.plugins.glow') end
    }

    -- hexokinase - color indicator for html/css/etc
    use {
        'RRethy/vim-hexokinase',
        run = 'make hexokinase',
        config = function() require('config.plugins.hexokinase') end
    }

    -- hop - easymotion replacement
    use {
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        config = function() require('config.plugins.hop') end
    }

    -- indent-blankline - show fancy indent guidelines
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function() require('config.plugins.indent-blankline') end
    }

    -- lsp-zero - good setup for lsp
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            'neovim/nvim-lspconfig',
            {'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            'williamboman/mason-lspconfig.nvim',

            'hrsh7th/nvim-cmp',     -- base autocomplete plugin
            'hrsh7th/cmp-nvim-lsp', --   source: language server data
            'hrsh7th/cmp-path',     --   source: file system completion
            {'hrsh7th/cmp-buffer',    --   source: buffer completions
                --config = function() require('config.plugins.cmp-buffer') end
            },
            'L3MON4D3/LuaSnip',     --   source - snippets
        },
        config = function() require('config.plugins.lsp-zero') end
    }

    -- lualine - fancy statusline
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'nvim-tree/nvim-web-devicons',
            opt = true
        },
        config = function() require('config.plugins.lualine') end
    }

    -- marks - show marks in sign column
    use {
        'chentoast/marks.nvim',
        config = function() require('config.plugins.marks') end
    }

    -- matchup - advanced matching pairs with %
    use 'andymass/vim-matchup'

    -- operator-replace - R{motion} replaces with current register
    use {
        'kana/vim-operator-replace',
        requires = { {'kana/vim-operator-user'} },
        config = function() require('config.plugins.operator-replace') end
    }

    -- pretty_hover - clean up lsp dialogs
    use {
        'Fildo7525/pretty_hover',
        config = function() require('config.plugins.prettyhover') end
    }

    -- rainbow parens
    use {
        'hiphish/rainbow-delimiters.nvim',
        config = function() require('config.plugins.rainbow') end
    }

    -- regexplainer - show help info for regexes
    use {
        'ArjunSahlot/nvim-regexplainer',
        -- this fork fixes a bug with errors showing in temporary buffers like Trouble
        -- 'bennypowers/nvim-regexplainer',
        requires = {
            'nvim-treesitter/nvim-treesitter',
            'MunifTanjim/nui.nvim'
        },
        config = function() require('config.plugins.regexplainer') end
    }

    -- repeat - extend '.' repetition to plugins like surround
    use 'tpope/vim-repeat'

    -- schemastore - catalog of json schemas to check against
    use 'b0o/schemastore.nvim'

    -- sleuth - detect shift/tabwidth based upon the current file
    use 'tpope/vim-sleuth'

    -- surround - control surrounding quotes, brackets, html tags, etc
    use 'tpope/vim-surround'

    -- switch - toggle common cyclical words (true -> false -> true)
    use {
        'AndrewRadev/switch.vim',
        config = function() require('config.plugins.switch') end
    }

    -- tagalong - match open/ending html tags when changing with 'c'
    use 'AndrewRadev/tagalong.vim'

    -- telescope - fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = function() require('config.plugins.telescope') end
    }
    -- telescope - faster search
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }

    --use({
    --    -- requires modern terminal - not iterm2
    --    -- https://github.com/nvim-telescope/telescope-media-files.nvim
    --    'nvim-telescope/telescope-media-files.nvim',
    --    config = function()
    --        require('telescope').load_extension('media_files')
    --    end,
    --    -- ? requires = 'nvim-lua/popup.nvim'
    --})
    -- telescope - alternate file mappings
    use {
        'otavioschwanck/telescope-alternate',
        config = function() require('config.plugins.telescope-alternate') end
    }

    -- telescope - docker integration
    use {
        'lpoto/telescope-docker.nvim',
        config = function() require('config.plugins.telescope-docker') end
    }
    -- telescope - file browser
    use {
        'nvim-telescope/telescope-file-browser.nvim',
        requires = {'nvim-telescope/telescope.nvim', 'nvimlua/plenary.nvim'},
        config = function() require('config.plugins.telescope-file-browser') end
    }

    -- telescope - neoclip yank history
    use {
        'AckslD/nvim-neoclip.lua',
        requires = {
            {'nvim-telescope/telescope.nvim'}
        },
        config = function() require('config.plugins.telescope-neoclip') end
    }
    use {
        'nvim-tree/nvim-web-devicons'
    }

    -- text objects
    use 'kana/vim-textobj-entire'
    use 'kana/vim-textobj-line'
    use 'kana/vim-textobj-user'

    -- todo comment highlighter
    use {
        'folke/todo-comments.nvim',
        config = function() require('config.plugins.todo-comments') end
    }

    -- treesitter - syntax parser
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('config.plugins.treesitter') end
    }
    -- treesitter - view AST of file
    use 'nvim-treesitter/playground'
    -- treesitter - always show function context as top line
    use {
        'nvim-treesitter/nvim-treesitter-context',
        config = function() require('config.plugins.treesitter-context') end
    }
    -- treesitter - text objects
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
        requires = 'nvim-treesitter/nvim-treesitter',
        config = function() require('config.plugins.treesitter-textobjects') end
    }

    -- trouble - pretty quickfix/notices/diagnostics
    use {
        'folke/trouble.nvim',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function() require('config.plugins.trouble') end
    }

    -- twilight - dim inactive parts of file
    use {
        'folke/twilight.nvim',
        config = function() require('config.plugins.twilight') end
    }

    -- undotree - view history of changes
    use {
        'mbbill/undotree',
        config = function() require('config.plugins.undotree') end
    }

    -- unimpaired - navigation functions for the ] and [ keys
    -- forked repo to override some mappings
    use 'jfinnis/vim-unimpaired'

    -- zen mode - focus on current buffer only
    use {
        'folke/zen-mode.nvim',
        config = function() require('config.plugins.zenmode') end
    }
end)
