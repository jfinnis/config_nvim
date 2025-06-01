--
-- barbecue - breadcrumbs as the top line
--

return {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    dependencies = {
        'SmiteshP/nvim-navic',
        'nvim-tree/nvim-web-devicons', -- optional dependency
    },
    opts = {
        -- configurations go here
    },
    config = function()
        require('barbecue').setup {
            theme = {
                dirname = { fg = '#757575' },
            }
        }
    end
}
