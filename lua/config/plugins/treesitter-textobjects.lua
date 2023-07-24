--
-- treesitter-textobjects settings
--

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
                ['in'] = '@number.inner',
                ['ax'] = '@assignment.lhs',
                ['ix'] = '@assignment.rhs',
            },

            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V', -- linewise
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
            include_surrounding_whitespace = true
        },

        swap = {
            enable = true,
            swap_next = {
                ['>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<a'] = '@parameter.inner',
            }
        }
    }
}

-- aa/ia text objects => in html, switch to tag attributes instead of parameters
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '',
    callback = function()
        local textobj = vim.bo.filetype == 'html' and 'attribute' or 'parameter'

        -- select textobject
        local select_outer = '@'..textobj..'.outer'
        local select_inner = '@'..textobj..'.inner'
        vim.keymap.set({'o', 'v'}, 'aa', ":lua require'nvim-treesitter.textobjects.select'.select_textobject('"..select_outer.."', 'textobjects', {'o', 'v'})<CR>", {silent = true})
        vim.keymap.set({'o', 'v'}, 'ia', ":lua require'nvim-treesitter.textobjects.select'.select_textobject('"..select_inner.."', 'textobjects', {'o', 'v'})<CR>", {silent = true})

        -- override swap
        local swap_textobj = '@'..textobj..'.outer'
        vim.keymap.set('n', '>a', ":lua require'nvim-treesitter.textobjects.swap'.swap_next('"..swap_textobj.."', 'textobjects')<cr>")
        vim.keymap.set('n', '<a', ":lua require'nvim-treesitter.textobjects.swap'.swap_previous('"..swap_textobj.."', 'textobjects')<cr>")
    end
})
