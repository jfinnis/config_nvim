--
-- neocodeium settings - replaces codeium
--

return {
    {
        'monkoose/neocodeium',
        event = 'VeryLazy',
        config = function()
            local neocodeium = require('neocodeium')
            neocodeium.setup({
                filetypes = {
                    -- ignore in special filetypes where we don't want suggestions
                    TelescopePrompt = false,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    ['dap-repl'] = false,
                    ['.'] = false,
                    
                }
            })

            vim.keymap.set('i', '<tab>i', neocodeium.accept,
                { desc = '[<tab>i] Accept suggestion' })
            vim.keymap.set('i', '<tab>]', function() neocodeium.cycle(1) end,
                { desc = '[<tab>i] Next suggestion' })
            vim.keymap.set('i', '<tab>[', function() neocodeium.cycle(-1) end,
                { desc = '[<tab>i] Previous suggestion' })
        end,
    },

    -- {
    --     'Exafunction/codeium.vim',
    --     event = 'BufEnter',
    --     config = function()
    --         vim.g.codeium_disable_bindings = 1
    --
    --         -- accept suggestion
    --         vim.keymap.set('i', '<tab>i', function() return vim.fn['codeium#Accept']() end,
    --             { desc='Accept AI Suggestion', expr=true, silent=true})
    --
    --         -- clear suggestion
    --         vim.keymap.set('i', '<c-l>', function() return vim.fn['codeium#Clear']() end,
    --             { desc='Clear AI Suggestion', expr=true, silent=true})
    --
    --         -- next suggestion
    --         vim.keymap.set('i', '<tab>]', function() return vim.fn['codeium#CycleCompletions'](1) end,
    --             { desc='Next AI Suggestion', expr=true, silent=true})
    --
    --         -- prev suggestion
    --         vim.keymap.set('i', '<tab>[', function() return vim.fn['codeium#CycleCompletions'](-1) end,
    --             { desc='Previous AI Suggestion', expr=true, silent=true})
    --
    --         -- open chat
    --         vim.keymap.set('n', '<tab>I', function() return vim.fn['codeium#Chat']() end,
    --             { desc='<tab> Open A[I] Chat', expr=true, silent=true})
    --     end
    -- }
}
