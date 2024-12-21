--
-- treesitter settings
--

return {
    {
        -- treesitter - syntax parser
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup { -- A list of parser names, or "all"
                ensure_installed = { "javascript", "typescript", "bash", "java", "html", "lua", "json", "c", "vim", "vimdoc", "query", "make", "css", "diff", "dockerfile", "go", "graphql", "python", "ruby", "sql", "yaml", "gitignore", "gitcommit", "git_config" },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                auto_install = true,

                -- Need to enable the modules because they're disabled by default.
                highlight = {
                    enable = true,
                    -- disable accepts list of languages or a function
                    --disable = function(lang, bufnr)
                    -- example: disable in large C++ buffers
                    -- return lang == "cpp" and vim.api.nvim_buf_line_count(bufnr) > 50000
                    --end,
                },

                incremental_selection = {
                    enable = true,
                    keymaps = {
                        scope_incremental = 'v',
                    }
                },

                textobjects = {
                    enable = true
                },

                indent = {
                    enable = true
                },

                matchup = {
                    enable = true
                }
            }

            -- link the custom treesitter highlights created in ../../after/queries/{ft}/highlights.scm
            -- to the highlight group they should be colored alongside
            vim.api.nvim_set_hl(0, "@prototype", {link = "@property"})
            vim.api.nvim_set_hl(0, "@null", {link = "@constant.builtin"})
            vim.api.nvim_set_hl(0, "@NaN", {link = "@number"})
            vim.api.nvim_set_hl(0, "@this", {link = "@constant.builtin"})
            vim.api.nvim_set_hl(0, "@undefined", {link = "@constant.builtin"})
            vim.api.nvim_set_hl(0, "@return_statement", {link = "@keyword"})
            -- link the matchup plugin treesitter integration background highlight
            vim.api.nvim_set_hl(0, "MatchupVirtualText", {link = "@constant.builtin"})

            -- need to set here to override vim's visual => visual-line mode
            vim.keymap.set('v', 'V', ":lua require'nvim-treesitter.incremental_selection'.node_decremental()<cr>")

            -- Workaround for error "No folds found" that sometimes occurs
            -- https://github.com/nvim-treesitter/nvim-treesitter/issues/1469#issuecomment-1141662730
            vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
                group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
                callback = function()
                    vim.opt.foldmethod     = 'expr'
                    vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
                end
            })
        end
    },

    {
        -- treesitter - always show function context as top line
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
            require 'treesitter-context'.setup {
                enable = true,
                mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = '‾',
                multiline_threshold = 5, -- Maximum number of lines to show for a single context

            }
        end
    },

    {
        -- treesitter - text objects
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = function()
            require'nvim-treesitter.configs'.setup {
                textobjects = {
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['aa'] = '@parameter.outer',
                            ['ia'] = '@parameter.inner',
                            ['ac'] = '@comment.outer',
                            ['ic'] = '@comment.outer',
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['am'] = '@class.outer',
                            ['im'] = '@class.inner',
                            ['an'] = '@number.inner',
                            ['in'] = '@number.inner',
                            ['ax'] = '@assignment.lhs',
                            ['ix'] = '@assignment.rhs',
                        },

                        -- You can choose the select mode (default is charwise 'v')
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * method: eg 'v' or 'o'
                        -- and should return the mode ('v' charwise, 'V' linewise, or
                        -- '<c-v>' blockwise) or a table mapping query_strings to modes.
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V', -- linewise
                            ['@function.inner'] = 'V',
                            ['@class.outer'] = '<c-v>', -- blockwise
                        },

                        -- If you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. Succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * selection_mode: eg 'v'
                        -- and should return true of false
                        include_surrounding_whitespace = function(keys)
                            local query_string = keys.query_string
                            --local selection_mode = keys.selection_mode
                            if (query_string == '@parameter.inner'
                                or query_string == '@comment.outer'
                                or query_string == '@number.inner'
                                or query_string == '@assignment.rhs'
                                or query_string == '@assignment.lhs') then
                                return false
                            end
                            return true
                        end
                    },

                    swap = {
                        enable = true,
                        swap_next = {
                            -- ['>a'] = '@parameter.inner', -- using iswap.nvim to allow more general swaps
                            ['>f'] = '@function.outer',
                            ['>m'] = '@class.outer',
                            ['>n'] = '@number.inner'
                        },
                        swap_previous = {
                            -- ['<a'] = '@parameter.inner',
                            ['<f'] = '@function.outer',
                            ['<m'] = '@class.outer',
                            ['<n'] = '@number.inner'
                        }
                    },

                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            [']a'] = '@parameter.inner',
                            [']f'] = '@function.outer',
                            [']m'] = '@class.outer'
                        },
                        goto_previous_start = {
                            ['[a'] = '@parameter.inner',
                            ['[f'] = '@function.outer',
                            ['[m'] = '@class.outer'
                        },
                    },

                    lsp_interop = {
                        enable = true,
                        floating_preview_opts = {
                            border = 'double'
                        },
                        peek_definition_code = {
                            ["gp"] = "@function.outer",
                            ["gP"] = "@class.outer",
                        }
                    }
                }
            }

            -- aa/ia text objects => in html, switch to tag attributes instead of parameters
            vim.api.nvim_create_autocmd('BufEnter', {
                pattern = '',
                callback = function()
                    local textobj = vim.bo.filetype == 'html' and 'attribute' or 'parameter'

                    -- override select
                    local select_outer = '@'..textobj..'.outer'
                    local select_inner = '@'..textobj..'.inner'
                    vim.keymap.set({'o', 'v'}, 'aa', ":lua require'nvim-treesitter.textobjects.select'.select_textobject('"..select_outer.."', 'textobjects', {'o', 'v'})<CR>", {silent = true})
                    vim.keymap.set({'o', 'v'}, 'ia', ":lua require'nvim-treesitter.textobjects.select'.select_textobject('"..select_inner.."', 'textobjects', {'o', 'v'})<CR>", {silent = true})

                    -- override swap
                    --   future fix: cant get working now - not too important to be able to reorder 
                    --   html attributes in tags
                    --local swap_textobj = '@'..textobj..'.outer'
                    --vim.keymap.set('n', '>a', ":lua require'nvim-treesitter.textobjects.swap'.swap_next('"..swap_textobj.."', 'textobjects')<CR>")
                    --vim.keymap.set('n', '<a', ":lua require'nvim-treesitter.textobjects.swap'.swap_previous('"..swap_textobj.."', 'textobjects')<CR>")
                end
            })
        end
    },
}
