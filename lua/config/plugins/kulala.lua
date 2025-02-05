--
-- kulala.nvim - api testing inside Neovim buffers
--

vim.filetype.add({
  extension = {
    ['http'] = 'http',
  },
})

return {
    'mistweaverco/kulala.nvim',
    opts = {
        display_mode = 'split', -- float | split
        q_to_close_float = true,
        split_direction = 'horizontal', -- vertical | horizontal
        default_view = 'body', -- body | headers | headers_body | verbose
        show_icons = 'on_request', -- on_request | above_request | below_request | nil
        winbar = true,
        default_winbar_panes = { 'body', 'headers', 'verbose', 'stats', 'script_output' }, -- also headers_body
        environment_scope = 'g', -- b = buffer | g = global
        -- example certificates
        --certificates = {
        --    ["localhost"]= {
        --        cert = vim.fn.stdpath("config") .. "/certs/localhost.crt",
        --        key = vim.fn.stdpath("config") .. "/certs/localhost.key",
        --    },
        --    ["www.somewhere.com:8443"] = {
        --        cert = "/home/userx/certs/somewhere.crt",
        --        key = "/home/userx/certs/somewhere.key",
        --    },
        --},
    },
}
