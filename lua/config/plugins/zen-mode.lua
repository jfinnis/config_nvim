--
-- zen mode - focus on current buffer only
-- and related plugins neoscroll + twilight (disabled)
--

---@type boolean
local was_spotify_notif_running = false

return {
    -- neoscroll smooth scrolling
    {
        'karb94/neoscroll.nvim',
        opts = {
            easing = 'quadratic',
            -- don't set mappings by default, set them in Zenmode only (;z)
            mappings = {},
        },
        event = 'VeryLazy',
    },

    -- twilight - dim inactive parts of file
    -- Triggered through zen-mode mapping
    {
        'folke/twilight.nvim',
        config = function()
            require('twilight').setup({
                dimming = {
                    alpha = 0.25, -- amount of dimming
                    -- we try to get the foreground from the highlight groups or fallback color
                    color = { "Normal", "#ffffff" },
                    term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
                    inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
                },
                context = 10, -- amount of lines we will try to show around the current line
                treesitter = true, -- use treesitter when available for the filetype
                -- treesitter is used to automatically expand the visible text,
                -- but you can further control the types of nodes that should always be fully expanded
                expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
                    "function",
                    "method",
                    "table",
                    "if_statement",
                },
                exclude = {}, -- exclude these filetypes
            })
        end
    },

    -- zen mode - focus on current buffer only
    {
        'folke/zen-mode.nvim',
        config = function()
            require('zen-mode').setup({
                window = {
                    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
                    -- height and width can be:
                    -- * an absolute number of cells when > 1
                    -- * a percentage of the width / height of the editor when <= 1
                    -- * a function that returns the width or the height
                    width = 120, -- width of the Zen window
                    height = 1, -- height of the Zen window
                    -- by default, no options are changed for the Zen window
                    -- uncomment any of the options below, or add other vim.wo options you want to apply
                    options = {
                        -- signcolumn = "no", -- disable signcolumn
                        number = false, -- disable number column
                        -- relativenumber = false, -- disable relative numbers
                        -- cursorline = false, -- disable cursorline
                        -- cursorcolumn = false, -- disable cursor column
                        -- foldcolumn = "0", -- disable fold column
                        -- list = false, -- disable whitespace characters
                    },
                },
                plugins = {
                    -- disable some global vim options (vim.o...)
                    -- comment the lines to not apply the options
                    options = {
                        enabled = true,
                        ruler = false, -- disables the ruler text in the cmd line area
                        showcmd = false, -- disables the command in the last line of the screen
                    },
                    twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
                    gitsigns = { enabled = false }, -- disables git signs
                    tmux = { enabled = false }, -- disables the tmux statusline
                },
                -- callback where you can add custom code when the Zen window opens
                on_open = function(win)
                    -- use graceful neoscrolling - may be more clear when presenting
                    vim.keymap.set('n', '<C-u>', function()
                        require('neoscroll').ctrl_u({ duration = 250 })
                    end, { desc = '<C-u> Zenmode: Graceful scroll up' })
                    vim.keymap.set('n', '<C-d>', function()
                        require('neoscroll').ctrl_d({ duration = 250 })
                    end, { desc = '<C-d> Zenmode: Graceful scroll down' })

                    -- record state of spotify notification plugin to see if we restore
                    was_spotify_notif_running = require('spotify-notification.commands').is_running()
                    vim.api.nvim_command('SpotifyNotifStop')

                end,
                -- callback where you can add custom code when the Zen window closes
                on_close = function()
                    -- revert the neoscroll keybinds
                    vim.keymap.del('n', '<C-u>')
                    vim.keymap.del('n', '<C-d>')

                    -- only restore if was running before entering zen mode
                    if was_spotify_notif_running then
                        vim.api.nvim_command('SpotifyNotifStart')
                    end
                end,
            })

            vim.keymap.set('n', '<leader>z', ':ZenMode<cr>',
                { desc = '[;] [Z]en Mode + Twilight', silent = true })
        end
    },
}
