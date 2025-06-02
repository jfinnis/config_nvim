--
-- color schemes
--

function ToggleColorScheme()
    local color
    --if vim.g.colors_name ~= 'rose-pine-moon' and vim.g.colors_name ~= 'rose-pine' then
        --color = 'rose-pine-moon'
    if vim.g.colors_name ~= 'terafox' then
        color = 'terafox'
    else
        color = 'dayfox'
    end
    vim.cmd.colorscheme(color)
end
vim.keymap.set('n', '<leader>C', ToggleColorScheme, {desc = '[;cc] Toggle light/dark colorscheme'})

return {
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            require('rose-pine').setup({
                bold_vert_split = true,
                -- transparent telescope.nvim -- TODO doesn't do anything?
                highlight_groups = {
                    TelescopeBorder = { fg = 'highlight_high', bg = 'none' },
                    TelescopeNormal = { bg = 'none' },
                    TelescopePromptNormal = { bg = 'base' },
                    TelescopeResultsNormal = { fg = 'subtle', bg = 'none' },
                    TelescopeSelection = { fg = 'text', bg = 'base' },
                    TelescopeSelectionCaret = { fg = 'rose', bg = 'none' },
                }
            })
            --vim.cmd('colorscheme rose-pine')
        end
    },

    {
        'EdenEast/nightfox.nvim',
        config = function()
            require('nightfox').setup {
                options = {
                    transparent = true,
                },
                styles = {
                    comments = 'italics',
                }
            }
            vim.cmd('colorscheme terafox')

            -- apply extra color settings
            vim.api.nvim_set_hl(0, 'WinSeparator', { fg = 'antiquewhite' })
            vim.cmd[[highlight Comment gui=italic]]
            -- set bash highlighting that appears in package.json files
            vim.cmd('hi @bash.argumentFlag guifg=#689d6a')
            vim.cmd('hi @bash.specialKeyword guifg=#fe8019')
            -- make floating window background transparent
            vim.cmd[[ hi NormalFloat guifg=#e6eaea guibg=NONE ]]
        end
    },
}
