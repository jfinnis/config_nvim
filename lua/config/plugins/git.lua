--
-- git plugins
--

return {
    -- fugitive
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set('n', '<leader>gB', ':Git blame<cr>', { desc = '[;] [G]it [B]lame All Lines' })
            vim.keymap.set('n', '<leader>gs', ':G<cr>', { desc = '[;] [G]it [S]tatus and Staging' })
            vim.keymap.set({'n', 'v'}, '<leader>gw', ':GBrowse<cr>', { desc = '[;] [G]it [B]rowse' })
        end
    },

    -- fubitive - allow bitbucket for Git Browse
    { 'tommcdo/vim-fubitive' },
    --
    -- gitsigns - git file status in the signs, show/hide diffs
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                numhl = true, -- highlight line numbers
                linehl = false, -- highlight full lines
                culhl = false, -- highlight current line
                diff_opts = {
                    algorithm = 'myers',
                    internal = true,
                    indent_heuristic = true,
                    vertical = true,
                    linematch = true
                },
                max_file_length = 40000, -- Disable if file is longer than this (in lines)
                preview_config = {
                    -- Options passed to nvim_open_win
                    border = 'double',
                },
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                    delay = 150,
                    ignore_whitespace = true,
                },
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> <abbrev_sha>::<summary>',
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']g', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, {expr=true, desc='Jump to next git hunk'})

                    map('n', '[g', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, {expr=true, desc='Jump to previous git hunk'})

                    map('n', '<leader>ga', gs.stage_hunk, {desc='Toggle change to staged'})
                    map('n', '<leader>gu', gs.reset_hunk, {desc='Undo last staged change'})
                    map('n', '<leader>gp', gs.preview_hunk, {desc='Preview change'})
                    map('n', '<leader>gA', gs.stage_buffer, {desc='Add all changes in file'})
                    map('n', '<leader>gR', gs.reset_buffer_index, {desc='Reset whole file'})
                    map('n', '<leader>gb', function() gs.blame_line{full=true} end, {desc='Show git blame in popup window'})
                    -- use fugitive instead
                    --map('n', '<leader>gB', gs.toggle_current_line_blame, {desc='Toggle git blame on current line'})
                    map('n', '<leader>gd', gs.diffthis)
                    -- using telescope git status instead
                    --map('n', '<leader>gs', function() gs.setqflist('all') end, {desc='Git status - Show all changes in repo'})
                    map('n', '<leader>gg', function()
                        gs.toggle_deleted() -- deprecated - use preview_hunk_inline instead? doesn't show deleted lines
                        gs.toggle_linehl()
                        gs.toggle_word_diff()
                    end, {desc='Toggle all git changes'})

                    -- TODO: custom function to prompt for revision and git diff it
                    --map('n', '<leader>gD', function() gs.diffthis('~') end)
                    -- ;gs could also do show(revision)
                    -- Enter revision of file to show:

                    -- visual mode mappings
                    map('v', '<leader>ga', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc='Add change to staged'})
                    map('v', '<leader>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc='Remove change'})

                    -- Text object
                    map({'v', 'o', 'x'}, 'ig', ':Gitsigns select_hunk<CR>')
                end
            }
        end
    },
}
