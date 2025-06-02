--
-- telescope settings
-- telescope-docker, nvim-neoclip, telescope-fzf-native
-- telescope-hierarchy

return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        },
        config = function()
            local telescope_mappings = {
                ['<C-k>'] = require('telescope.actions.layout').toggle_preview,
                ['<C-x>'] = false,
                ['<C-h>'] = 'select_horizontal',
                ['<S-tab>'] = false,
                ['<tab>'] = 'toggle_selection',
                ['<C-,>'] = 'results_scrolling_up',
                ['<C-.>'] = 'results_scrolling_down',
                -- open the file and resume the picker
                ['<C-o>'] = false,
                ['<C-o>o'] = function(prompt_bufnr) require('telescope.actions').select_default(prompt_bufnr) require('telescope.builtin').resume() end,
                ['<C-o>v'] = function(prompt_bufnr) require('telescope.actions').select_vertical(prompt_bufnr) require('telescope.builtin').resume() end,
                ['<C-o>h'] = function(prompt_bufnr) require('telescope.actions').select_horizontal(prompt_bufnr) require('telescope.builtin').resume() end,
                ['<C-q>'] = require('trouble.sources.telescope').open,
            }

            require('telescope').setup{
                extensions = {
                    fzf = {}
                },
                defaults = {
                    prompt_prefix = ' 🔎 ',
                    selection_caret = ' → ',
                    multi_icon = '＋',
                    dynamic_preview_title = true,
                    path_display = 'smart',
                    wrap_results = false, -- maybe true for certain views
                    layout_strategy = 'horizontal',
                    mappings = { n = telescope_mappings, i = telescope_mappings },
                    file_ignore_patterns = { '^.git/' },
                }
            }

            require('telescope').load_extension('fzf')

            require('telescope').load_extension('fidget')
            vim.keymap.set('n', '<leader>fn', ':Telescope fidget<cr>', { desc = '[;] [F]ind [N]otifications' })

            local telescope = require('telescope.builtin')
            local themes = require('telescope.themes')

            -- ;a - search
            require('config.telescope.multigrep').setup()
            -- ;A - search under cursor
            vim.keymap.set('n', '<leader>A', function()
                telescope.grep_string({
                    word_match = '-w',
                    disable_coordinates = true
                })
            end, {desc='[;] Search For ex[A]ct String Under Cursor'})
            -- ;n - file finder
            vim.keymap.set('n', '<leader>n', function()
                telescope.find_files({
                    hidden = true
                })
            end, {desc='[;n] Search Files'})
            -- <space>f - file finder - just notes
            vim.keymap.set('n', '<space>f', function()
                telescope.find_files({
                    cwd = vim.fn.expand('~/Documents/neorg')
                })
            end, {desc='[<space>] [F]ind Neorg Notes'})
            -- ;fp - file finder - nvim plugins
            vim.keymap.set('n', '<leader>fp', function()
                telescope.find_files({
                    cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy')
                })
            end, {desc='[;] [F]ind inside [P]lugins Directory'})
            -- ;fs - fuzzy find cur buffer
            vim.keymap.set('n', '<leader>fs', function()
                telescope.current_buffer_fuzzy_find(themes.get_dropdown {
                    prompt_title = 'Search Current Buffer',
                    winblend = 7,
                    previewer = false,
                    -- TODO: how to set window options (title) to something else
                })
            end, {desc='[;] [F]ind [S]earch Term In Current Buffer'})

            --
            -- lsp extensions
            -- defined in lsp-zero file
            --

            -- gd - hover diagnostic in line
            -- gK - search definition of term
            -- gt - show type definition of term
            -- gy - show lsp symbols

            --
            -- git extensions
            --

            -- TODO: can git status toggle staged changes?
            -- ;fgs - git status
            vim.keymap.set('n', '<leader>fgs', function() telescope.git_status({ prompt_title = 'Git Status (<cr> to open, <tab> to stage/unstage)' }) end, {desc='[;f] [G]it [S]tatus'})
            -- ;fgS - git stash
            vim.keymap.set('n', '<leader>fgS', telescope.git_stash, {desc='[;f] [G]it [S]tash'})
            -- ;fgc - git commits of file
            vim.keymap.set('n', '<leader>fgc', telescope.git_bcommits, {desc='[;f] [G]it [C]ommits of File'})


            --
            -- vim extensions
            --

            -- ;fb - display open buffers
            vim.keymap.set('n', '<leader>fb', telescope.buffers, {desc='[F]ind Open [B]uffers'})
            -- ;fc - display vim commands
            vim.keymap.set('n', '<leader>fc', telescope.commands, {desc='[;] [F]ind Vim [C]ommands'})
            -- ;fC - display and preview colorschemes
            vim.keymap.set('n', '<leader>fC', function()
                telescope.colorscheme(require('telescope.themes').get_dropdown{
                    enable_preview = true,
                    winblend = 10,
                    previewer = false
                })
            end, {desc='[;] [F]ind [C]olorschemes'})
            -- ;fb - display telescope builtins
            vim.keymap.set('n', '<leader>fB', telescope.builtin, {desc='[;] [F]ind All Telescope [B]uiltins'})
            -- ;fh - display vim help tags
            vim.keymap.set('n', '<leader>fh', telescope.help_tags, {desc='[;] [F]ind Vim [H]elp Tags'})
            -- ;fH - display vim highlight groups
            vim.keymap.set('n', '<leader>fH', telescope.highlights, {desc='[;] [F]ind [H]ighlight Groups'})
            -- ;fk - display keymaps
            vim.keymap.set('n', '<leader>fk', telescope.keymaps, {desc='[;] [F]ind [K]eymaps'})
            -- ;fK - display man pages search
            vim.keymap.set('n', '<leader>fK', telescope.man_pages, {desc='[;fK] Search Man Pages'})
            -- ;fm - display marks
            vim.keymap.set('n', '<leader>fm', telescope.marks, {desc='[;] [F]ind [M]arks'})
            -- ;fo - display vim options
            vim.keymap.set('n', '<leader>fo', telescope.vim_options, {desc='[;] [F]ind Vim [O]ptions'})
            -- ;fq - display quickfix history
            vim.keymap.set('n', '<leader>fq', telescope.quickfixhistory, {desc='[;f] Display [Q]uickfix History'})
            -- ;fQ - display quickfix entries
            vim.keymap.set('n', '<leader>fQ', function()
                telescope.quickfix({
                    show_line = false,
                    trim_text = true,
                    fname_width = 30
                })
            end, {desc='[;f] [F]ind [Q]uickfix Entries'})
            -- ;fr - display registers
            vim.keymap.set('n', '<leader>fr', telescope.registers, {desc='[;] [F]ind [R]egisters'})
            -- ;fs - display spelling suggestions
            vim.keymap.set('n', 'z=', function()
                telescope.spell_suggest(themes.get_dropdown({
                    winblend = 7
                }))
            end, {desc='[;] [F]ind [S]pelling Suggestions'})
            -- q: - upgraded command history
            vim.keymap.set('n', 'q:', telescope.command_history, {desc='[q:] Upgraded Command History Window'})
            -- q/ - upgraded search history
            vim.keymap.set('n', 'q/', telescope.search_history, {desc='[q/] Upgraded Search History Window'})

            --
            -- misc
            --

            -- ;fe - search emoji
            vim.keymap.set('n', '<leader>fe', function()
                telescope.symbols(themes.get_dropdown({
                    sources = {'gitmoji', 'emoji'},
                    winblend = 7
                }))
            end, {desc='[;] Insert [E]moji'})
        end
    },

    {
        -- telescope - faster search
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },

    {
        -- telescope - neoclip yank history
        'AckslD/nvim-neoclip.lua',
        dependencies = {
            {'nvim-telescope/telescope.nvim'}
        },
        config = function()
            require('neoclip').setup({
                enable_macro_history = false,
            })
            require('telescope').load_extension('neoclip')
            vim.keymap.set('n', '<leader>fy', ':Telescope neoclip<cr>', { desc = '[;] [F]ind [Y]ank History' })
        end
    },

    {
        -- telescope - docker integration
        'lpoto/telescope-docker.nvim',
        config = function()
            require('telescope').setup {
                extensions = {
                    docker = {
                        -- These are the default values
                        theme = 'ivy',
                        binary = 'docker',
                        compose_binary = 'docker compose',
                        buildx_binary = 'docker buildx',
                        --machine_binary = 'docker-machine',
                        log_level = vim.log.levels.INFO,
                        init_term = 'tabnew', -- "vsplit new", "split new", ...
                        -- NOTE: init_term may also be a function that receives
                        -- a command, a table of env. variables and cwd as input.
                        -- This is intended only for advanced use, in case you want
                        -- to send the env. and command to a tmux terminal or floaterm
                        -- or something other than a built in terminal.
                    },
                },
            }
            require('telescope').load_extension 'docker'

            vim.keymap.set('n', '<leader>D', ':Telescope docker<cr>', {desc = '[;] Show [D]ocker Menu'})
            vim.keymap.set('n', '<leader>dd', ':Telescope docker containers<cr>', {desc = '[;] Show [D]ocker [d] Containers'})
            vim.keymap.set('n', '<leader>dc', ':Telescope docker compose<cr>', {desc = '[;] Show [D]ocker [C]ompose Files'})
            vim.keymap.set('n', '<leader>di', ':Telescope docker images<cr>', {desc = '[;] Show [D]ocker [I]mages'})
            vim.keymap.set('n', '<leader>df', ':Telescope docker files<cr>', {desc = '[;] Show [D]ocker [F]iles'})
        end
    },

    {
        'jmacadie/telescope-hierarchy.nvim',
        keys = {
            {
                'gri',
                '<cmd>Telescope hierarchy incoming_calls<cr>',
                desc = 'LSP: [gr] [I]ncoming Calls',
            },
            {
                'gro',
                '<cmd>Telescope hierarchy outgoing_calls<cr>',
                desc = 'LSP: [gr] [O]utgoing Calls',
            },
        },
        opts = {
            extensions = {
                hierarchy = {
                    -- plugin-specific options
                },
            },
        },
        config = function(_, opts)
            require('telescope').setup(opts)
            require('telescope').load_extension('hierarchy')
        end,
    }
}
