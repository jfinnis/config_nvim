--
-- rainbow parens
--

return {
    'hiphish/rainbow-delimiters.nvim',
    config = function()
        local rainbow_delimiters = require 'rainbow-delimiters'
        vim.g.rainbow_delimiters = {
            strategy = {
                [''] = rainbow_delimiters.strategy['global'],
                commonlisp = rainbow_delimiters.strategy['local']
            },
            query = {
                [''] = 'rainbow-delimiters',
                lua = 'rainbow-blocks'
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
