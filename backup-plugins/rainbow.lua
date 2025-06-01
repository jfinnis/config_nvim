--
-- rainbow parens
--

return {
    'hiphish/rainbow-delimiters.nvim',
    config = function()
        local rainbow_delimiters = require 'rainbow-delimiters'
        vim.g.rainbow_delimiters = {
            strategy = {
                [''] = 'rainbow-delimiters.strategy.global',
                commonlisp = 'rainbow-delimiters.strategy.local',
                vim = 'rainbow-delimiters.strategy.local',
            },
            query = {
                [''] = 'rainbow-delimiters',
                lua = 'rainbow-blocks'
            },
            priority = {
                [''] = 110,
                lua = 210,
            },
            highlight = {
                'RainbowDelimiterRed',
                'RainbowDelimiterYellow',
                'RainbowDelimiterBlue',
                'RainbowDelimiterOrange',
                'RainbowDelimiterGreen',
                'RainbowDelimiterViolet',
                'RainbowDelimiterCyan',
            }
        }
    end
}
