--
-- kulala.nvim
-- http rest client
--

-- need to create the http filetype to be recognized by Neovim
vim.filetype.add({
    extension = {
        ['http'] = 'http',
    },
})

return {
    'mistweaverco/kulala.nvim',
    ft = { 'http', 'rest', 'norg' },
    opts = {
        environment_scope = 'g', -- b = buffer, g = global
        default_env = 'dev',
        --request_timeout = nil

        ui = {
            display_mode = 'split',         -- float | split
            split_direction = 'horizontal', -- vertical | horizontal
            --win_opts = {},
            default_view = 'body',          -- body | headers | headers_body | verbose | fun(response:Response)
            winbar = true,
            -- default_winbar_panes = { 'body', 'headers', 'verbose', 'stats', 'script_output', 'report', 'headers_body', 'help' },
            show_variable_info_text = 'float', -- false, 'float'
            show_icons = 'on_request',
            autocomplete = true,
            formatter = true,
            disable_news_popup = true,
            scratchpad_default_contents = {
                '@MY_TOKEN_NAME=my_token_value',
                '',
                'POST https://httpbin.org/post HTTP/1.1',
                'accept: application/json',
                'content-type: application/json',
                '',
                '{',
                '  "foo": "bar"',
                '}',
            },
            report = {
                show_script_output = true,  -- true | false | 'on_error'
                show_asserts_output = true, -- true | false | 'on_error' | 'failed_only'
                show_summary = true,        -- true | false
            },
        },

        -- useful options for testing
        halt_on_error = false,
        show_request_summary = true,
        disable_script_print_output = false,

        -- example certificates
        --certificates = {
        --    ['localhost']= {
        --        cert = vim.fn.stdpath('config') .. '/certs/localhost.crt',
        --        key = vim.fn.stdpath('config') .. '/certs/localhost.key',
        --    },
        --    ['www.somewhere.com:8443'] = {
        --        cert = '/home/userx/certs/somewhere.crt',
        --        key = '/home/userx/certs/somewhere.key',
        --    },
        --},

        global_keymaps = {
            ['Replay the last request'] = false, -- set to false to disable
            ['Open scratchpad'] = false,
            ['Open kulala'] = false,
            ['Close window'] = false,

            ['Send request'] = {
                '<cr>',
                function() require('kulala').run() end,
                mode = { 'n', 'v' },
                ft = { 'http', },
                desc = '[Enter] Kulala - Send request' -- optional description, otherwise inferred from the key
            },
            ['Send all requests'] = {
                '<s-cr>',
                function() require('kulala').run_all() end,
                mode = { 'n', 'v' },
                ft = { 'http', },
                desc = '[Shift+Enter] Kulala - Send all requests'
            },
            ['Copy as cURL'] = {
                '<localleader>c',
                function() require('kulala').copy() end,
                ft = { 'http', 'norg' },
                desc = '[<Space>c] Kulala - Copy as curl'
            },
            ['Paste from curl'] = {
                '<localleader>p',
                function() require('kulala').from_curl() end,
                ft = { 'http', 'norg' },
                desc = '[<Space>p] Kulala - Paste from curl'
            },
            ['Jump to next request'] = {
                ']r',
                function() require('kulala').jump_next() end,
                ft = { 'http', 'norg' },
                desc = '`]` Kulala - Next [r]equest'
            },
            ['Jump to previous request'] = {
                '[r',
                function() require('kulala').jump_prev() end,
                ft = { 'http', 'norg' },
                desc = '`[` Kulala - Previous [r]equest'
            },
            ['Find request'] = {
                '<localleader>r',
                function() require('kulala').search() end,
                ft = { 'http', },
                desc = '[Space] Kulala - Sea[r]ch requests'
            },
            ['Select environment'] = {
                '<localleader>e',
                function() require('kulala').set_selected_env() end,
                ft = { 'http', },
                desc = '[Space] Kulala - Change [e]nvironment'
            },

            -- TODO:
            -- ['Manage Auth Config'] = { 'u', function() require('lua.kulala.ui.auth_manager').open_auth_config() end, ft = { 'http', 'rest' }, },
        },
    },
}
