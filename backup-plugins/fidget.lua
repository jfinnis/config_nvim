--
-- fidget LSP startup notifications
--

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
