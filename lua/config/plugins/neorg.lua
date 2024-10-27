--
-- neorg settings
--

require("neorg").setup {
    load = {
        ['core.defaults'] = {}, -- loads default behavior
        ['core.concealer'] = { -- adds pretty icons to documents
            config = {
                icon_preset = 'diamond',
                icons = {
                    todo = {
                        on_hold = {
                            icon = '⏸︎'
                        },
                        cancelled = {
                            icon = '✘'
                        },
                    }
                }
            }
        },
        ['core.dirman'] = { -- manages neorg workspaces
            config = {
                workspaces = {
                    notes = '~/Documents/neorg',
                },
                default_workspace = 'notes',
            },
        },
        ['core.esupports.metagen'] = {
            config = {
                author = 'josh',

                update_date = false, -- TODO: would like to set to true but having autosave issues
                -- undojoin_updates = true -- Must be paired with undo/redo autosave mappings
            }
        },
        ['core.summary'] = {},
        ['core.keybinds'] = {
            config = {
                hook = function(keybinds)
                    -- TODO: these undo/redo fixes for autosave only seem to work one single time
                    -- will disable updating date for now
                    -- vim.keymap.set('n', 'u', function()
                    --     require('neorg.modules').get_module('core.esupports.metagen').skip_next_update()
                    --     local k = vim.api.nvim_replace_termcodes('u<c-o>', true, false, true)
                    --     vim.api.nvim_feedkeys(k, 'n', false)
                    -- end)
                    -- vim.keymap.set('n', '<C-r>', function()
                    --     require('neorg.modules').get_module('core.esupports.metagen').skip_next_update()
                    --     local k = vim.api.nvim_replace_termcodes('<c-r><c-o>', true, false, true)
                    --     vim.api.nvim_feedkeys(k, 'n', false)
                    -- end)
                end,
            }
        },
        ['core.text-objects'] = {},
        ['core.looking-glass'] = {},
        ['core.presenter'] = {
            config = {
                zen_mode = 'zen-mode'
            }
        },
    },
}

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'norg',
    callback = function()
        -- open index and return
        vim.keymap.set('n', '<LocalLeader>N', ':Neorg index<cr>', { desc = '[<space>] Open [N]eorg', buffer = true })
        vim.keymap.set('n', '<LocalLeader>nr', ':Neorg return<cr>',
            { desc = '[<space>] [N]eorg [R]eturn', buffer = true })

        -- inject metadata
        vim.keymap.set('n', '<LocalLeader>m', ':Neorg inject-metadata<cr>',
            { desc = '[<space>] Add Neorg [M]etadata', buffer = true })

        -- text object mappings
        vim.keymap.set('n', '<LocalLeader>k', '<Plug>(neorg.text-objects.item-up)',
            { desc = '[<space>k] Neorg: Move heading level down', buffer = true })
        vim.keymap.set('n', '<LocalLeader>j', '<Plug>(neorg.text-objects.item-down)',
            { desc = '[<space>j] Neorg: Move heading level up', buffer = true })
        vim.keymap.set({ 'o', 'x' }, 'ih', '<Plug>(neorg.text-objects.textobject.heading.inner)',
            { desc = '[ih] Text Object: Neorg heading', buffer = true })
        vim.keymap.set({ 'o', 'x' }, 'ah', '<Plug>(neorg.text-objects.textobject.heading.outer)',
            { desc = '[ah] Text Object: Neorg heading', buffer = true })

        -- code block magnify (edit in own tmp buffer)
        -- TODO: doesn't work?
        -- vim.keymap.set('n', '<LocalLeader>z', ':Neorg keybind all core.looking-glass.magnify-code-block<cr>', { desc = '[<space>] [Z]oom code block to own buffer', buffer = true })
    end
})

-- TODO: add mapping to generate index

vim.wo.foldlevel = 99 -- overriding value of 7
--vim.wo.conceallevel = 2 -- set in settings.lua
