--
-- tmux - multiplexer management
--

return {
    -- nav/resizing of splits
    {
        'mrjones2014/smart-splits.nvim',
        config = function()
            require('smart-splits').setup({
                -- Ignored buffer types (only while resizing)
                ignored_buftypes = {
                    'nofile',
                    'quickfix',
                    'prompt',
                },
                -- the default number of lines/columns to resize by at a time
                default_amount = 3,
                -- Desired behavior when your cursor is at an edge and you
                -- are moving towards that same edge:
                -- 'wrap' => Wrap to opposite side
                -- 'split' => Create a new split in the desired direction
                -- 'stop' => Do nothing
                -- function => You handle the behavior yourself
                at_edge = 'wrap',
                -- Desired behavior when the current window is floating:
                -- 'previous' => Focus previous Vim window and perform action
                -- 'mux' => Always forward action to multiplexer
                float_win_behavior = 'previous',
                -- when moving cursor between splits left or right,
                -- place the cursor on the same row of the *screen*
                -- regardless of line numbers. False by default.
                -- Can be overridden via function parameter, see Usage.
                move_cursor_same_row = false,
                -- whether the cursor should follow the buffer when swapping
                -- buffers by default; it can also be controlled by passing
                -- `{ move_cursor = true }` or `{ move_cursor = false }`
                -- when calling the Lua function.
                cursor_follows_swapped_bufs = false,
                -- ignore these autocmd events (via :h eventignore) while processing
                -- smart-splits.nvim computations, which involve visiting different
                -- buffers and windows. These events will be ignored during processing,
                -- and un-ignored on completed. This only applies to resize events,
                -- not cursor movement events.
                ignored_events = {
                    'BufEnter',
                    'WinEnter',
                },
                -- enable or disable a multiplexer integration;
                -- automatically determined, unless explicitly disabled or set,
                -- by checking the $TERM_PROGRAM environment variable,
                -- and the $KITTY_LISTEN_ON environment variable for Kitty.
                -- You can also set this value by setting `vim.g.smart_splits_multiplexer_integration`
                -- before the plugin is loaded (e.g. for lazy environments).
                multiplexer_integration = nil,
                -- disable multiplexer navigation if current multiplexer pane is zoomed
                disable_multiplexer_nav_when_zoomed = true,
            })

            -- recommended mappings
            -- resizing splits
            -- these keymaps will also accept a range,
            -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
            vim.keymap.set('n', '<M-H>', require('smart-splits').resize_left)
            vim.keymap.set('n', '<M-J>', require('smart-splits').resize_down)
            vim.keymap.set('n', '<M-K>', require('smart-splits').resize_up)
            vim.keymap.set('n', '<M-L>', require('smart-splits').resize_right)
            -- moving between splits
            vim.keymap.set('n', '<M-h>', require('smart-splits').move_cursor_left)
            vim.keymap.set('n', '<M-j>', require('smart-splits').move_cursor_down)
            vim.keymap.set('n', '<M-k>', require('smart-splits').move_cursor_up)
            vim.keymap.set('n', '<M-l>', require('smart-splits').move_cursor_right)
            -- vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)
            -- swapping buffers between windows
            vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
            vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
            vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
            vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
        end,
    }
}
