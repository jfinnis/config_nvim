--
-- marker-groups - persistent annotations
--

return {
    'jameswolensky/marker-groups.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim', -- Required
        'nvim-telescope/telescope.nvim', -- Optional: for fuzzy search
    },
    config = function()
        require('marker-groups').setup({
            -- Context shown around markers in viewer/preview
            context_lines = 2,
            -- Virtual text display & highlight groups
            max_annotation_display = 50, -- truncate long annotations
            keymaps = {
                mappings = {
                    marker = {
                        -- add = 'a'
                        -- delete = 'd'
                        -- edit = 'e'
                        list = false,
                        info = false,
                    },
                    view = {
                        -- toggle = 'v'
                    },
                    telescope = {
                        groups = { suffix = 'gs', desc = 'Telescope: marker groups' },
                        markers = { suffix = 'f', desc = 'Telescope: markers in active group' },
                    },
                    group = {
                        -- create = 'gc',
                        select = false,
                        -- list = 'gl',
                        -- rename = 'gr',
                        -- delete = 'gd',
                        -- info = 'gi',
                        -- from_branch?? = 'gb',
                    }
                }
            }
        })
    end,
}
