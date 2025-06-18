--
-- fidget LSP startup notifications
--

-- clear fidget notifications alongside normal <C-L> behavior
vim.keymap.set('n', '<c-l>', ':Fidget clear<cr><c-l>')

return {
    'j-hui/fidget.nvim',
    opts = {
        notification = {
            override_vim_notify = true,  -- Automatically override vim.notify() with Fidget
            view = {
                stack_upwards = false, -- Display notification items from bottom to top
            },
            window = {
                border = 'rounded',
                winblend = 0,
                align = 'top',
            },
        },
    },
}
