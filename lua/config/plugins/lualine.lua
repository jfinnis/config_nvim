--
-- lualine settings
--

require('lualine').setup{
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '|'},
        section_separators = { left = '', right = ''},
        ignore_focus = {}, -- useful to ignore status line of file tree, etc
        globalstatus = true, -- don't do one status line per terminal
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {
            {
                'buffers',
                symbols = {
                    modified = ' +'
                }
            },
        },
        lualine_x = {
            {
                'diagnostics',
                sections = {'error', 'warn', 'info', 'hint'},
                symbols = {error = '✘ ', warn = '▲ ', hint = '⚑ ', info = '» '},
                always_visible = false
            }
        },
        lualine_y = {
            {
                'filetype',
                fmt = function(str)
                    if str == 'javascriptreact' then
                        return 'jsx'
                    elseif str == 'typescriptreact' then
                        return 'tsx'
                    end
                    return str
                end
            }
        },
        lualine_z = {'location'}
        -- may include lua script "os.date('%a')"
        --   TODO: include spotify current song?
        --   {'Spotify', cond = isSpotifyPlaying, icon = SpotifyIcon?}
        --   can also just google if it exists
        --   draw_empty = false,   -- Whether to draw component even if it's empty.
                                -- Might be useful if you want just the separator.
        --
    },
    -- not displayed because of `globalstatus`
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
