--
-- color schemes
--

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
        end
    },
}
