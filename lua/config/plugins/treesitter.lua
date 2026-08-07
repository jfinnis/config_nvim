--
-- treesitter settings
--
-- nvim-treesitter
-- nvim-treesitter-context
--

return {
    {
        -- treesitter - syntax parser (install/update parsers + queries only)
        'nvim-treesitter/nvim-treesitter',
        --branch = 'main',
        lazy = false, -- must not be lazy-loaded
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter').install({ 'javascript', 'typescript', 'tsx', 'bash',
                'java', 'html', 'lua', 'json', 'c', 'vim', 'vimdoc', 'query', 'make', 'css',
                'diff', 'dockerfile', 'go', 'graphql', 'python', 'rust', 'ruby', 'sql', 'yaml',
                'gitignore', 'gitcommit', 'git_config', 'http', 'fennel', 'clojure', 'scheme',
            })

            -- folding
            vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo[0][0].foldmethod = 'expr'

            -- indenting - considered experimental
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

            -- link the custom treesitter highlights created in ../../after/queries/{ft}/highlights.scm
            -- to the highlight group they should be colored alongside
            vim.api.nvim_set_hl(0, "@prototype", {link = "@property"})
            vim.api.nvim_set_hl(0, "@null", {link = "@constant.builtin"})
            vim.api.nvim_set_hl(0, "@NaN", {link = "@number"})
            vim.api.nvim_set_hl(0, "@this", {link = "@constant.builtin"})
            vim.api.nvim_set_hl(0, "@undefined", {link = "@constant.builtin"})
            vim.api.nvim_set_hl(0, "@return_statement", {link = "@keyword"})
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
            require('nvim-treesitter-textobjects').setup {
                select = {
                    lookahead = true,
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V',  -- linewise
                        ['@function.inner'] = 'V',
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    include_surrounding_whitespace = function(keys)
                        local query_string = keys.query_string
                        if (query_string == '@parameter.inner'
                            or query_string == '@comment.outer'
                            or query_string == '@number.inner'
                            or query_string == '@assignment.rhs'
                            or query_string == '@assignment.lhs') then
                            return false
                        end
                        return true
                    end,
                },
                move = {
                    set_jumps = true,
                },
            }

            -- select
            local select_keymaps = {
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
            }
            local function ts_select(qs)
                return function()
                    require('nvim-treesitter-textobjects.select').select_textobject(qs, 'textobjects')
                end
            end
            for ks, qs in pairs(select_keymaps) do
                vim.keymap.set({ 'x', 'o' }, ks, ts_select(qs), { silent = true })
            end

            -- swap
            local swap_next = {
                ['>f'] = '@function.outer',
                ['>m'] = '@class.outer',
                ['>n'] = '@number.inner',
            }
            local swap_previous = {
                ['<f'] = '@function.outer',
                ['<m'] = '@class.outer',
                ['<n'] = '@number.inner',
            }
            for ks, qs in pairs(swap_next) do
                vim.keymap.set('n', ks, function()
                    require('nvim-treesitter-textobjects.swap').swap_next(qs, 'textobjects')
                end, { silent = true })
            end
            for ks, qs in pairs(swap_previous) do
                vim.keymap.set('n', ks, function()
                    require('nvim-treesitter-textobjects.swap').swap_previous(qs, 'textobjects')
                end, { silent = true })
            end

            -- move
            local goto_next = {
                [']a'] = '@parameter.inner',
                [']f'] = '@function.outer',
                [']m'] = '@class.outer',
            }
            local goto_previous = {
                ['[a'] = '@parameter.inner',
                ['[f'] = '@function.outer',
                ['[m'] = '@class.outer',
            }
            for ks, qs in pairs(goto_next) do
                vim.keymap.set({ 'n', 'x', 'o' }, ks, function()
                    require('nvim-treesitter-textobjects.move').goto_next_start(qs, 'textobjects')
                end, { silent = true })
            end
            for ks, qs in pairs(goto_previous) do
                vim.keymap.set({ 'n', 'x', 'o' }, ks, function()
                    require('nvim-treesitter-textobjects.move').goto_previous_start(qs, 'textobjects')
                end, { silent = true })
            end

            -- aa/ia text objects => in html, switch to tag attributes instead of parameters
            vim.api.nvim_create_autocmd('BufEnter', {
                pattern = '',
                callback = function()
                    local textobj = vim.bo.filetype == 'html' and 'attribute' or 'parameter'
                    vim.keymap.set({ 'x', 'o' }, 'aa', ts_select('@' .. textobj .. '.outer'), { silent = true })
                    vim.keymap.set({ 'x', 'o' }, 'ia', ts_select('@' .. textobj .. '.inner'), { silent = true })
                end,
            })
        end
    },
}
