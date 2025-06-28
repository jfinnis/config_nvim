--
-- fidget LSP startup notifications
--

-- clear fidget notifications alongside normal <C-L> behavior
vim.keymap.set('n', '<c-l>', ':Fidget clear<cr><c-l>')

return {
    'j-hui/fidget.nvim',
    opts = {
        notification = {
            filter = vim.log.levels.INFO,
            override_vim_notify = true,  -- Automatically override vim.notify() with Fidget
            view = {
                stack_upwards = true, -- Display notification items from bottom to top
            },
            window = {
                border = 'rounded',
                winblend = 20,
                align = 'bottom',
                x_padding = 0,
            },
        },

        -- lsp subsystem
        progress = {
            ignore = {}, -- list of lsp servers to ignore
            display = {
                skip_history = true, -- progress notifications omitted from history
            }
        }
    },
}
