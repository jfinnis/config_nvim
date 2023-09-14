--
-- telescope-alternate mappings
--

-- mapping syntax
-- mapping: {
--     'current-file', { { { 'destination', 'label', ignoreCreate (true or false) } }, ... }
-- }

-- example
-- { 'app/models/(.*).rb', {
--     { 'db/helpers/**/*[1]*.rb', 'Helper' } },
--     { 'app/controllers/**/*[1:pluralize]_controller.rb', 'Controller' } },
-- },

-- transformers    description
-- camel_to_kebap  userName -> user-name
-- kebap_to_camel  user-name -> userName
-- pluralize       userName -> userNames
-- singularize     userNames -> userName

-- custom transformer syntax
-- transformers = { -- custom transformers
--   change_to_uppercase = function(w) return my_uppercase_method(w) end
-- },


require('telescope-alternate').setup({
    presets = {}, --{ 'rails', 'rspec', 'nestjs', 'angular' }, Telescope pre-defined mapping presets
    open_only_one_with = 'vertical_split', -- when just have only possible file, open it with. Can also be horizontal_split and vertical_split
    mappings = {
        { 'src/(.*)/(.*)/(.*).ts', {
            {'src/[1]/[2]/__test__/[3].test.ts', 'Test'},
        }},
        { 'src/(.*)/(.*)/(.*).tsx', {
            {'src/[1]/[2]/__test__/[3].test.tsx', 'Test'},
        }},
        { 'src/(.*)/(.*).ts', {
            {'src/[1]/__test__/[2].test.ts', 'Test'},
        }},
        { 'src/(.*)/(.*).tsx', {
            {'src/[1]/__test__/[2].test.tsx', 'Test'},
        }},
        { 'src/(.*)/__test__/(.*).test.ts', {
            {'src/[1]/[2].ts', 'Test'},
        }},
        { 'src/(.*)/__test__/(.*).test.tsx', {
            {'src/[1]/[2].tsx', 'Test'},
        }},
        { 'src/(.*)/(.*)/__test__/(.*).test.ts', {
            {'src/[1]/[2]/[3].ts', 'Test'},
        }},
        { 'src/(.*)/(.*)/__test__/(.*).test.tsx', {
            {'src/[1]/[2]/[3].tsx', 'Test'},
        }},



--      { 'app/services/(.*)_services/(.*).rb', { -- alternate from services to contracts / models
--        { 'app/contracts/[1]_contracts/[2].rb', 'Contract' }, -- Adding label to switch
--        { 'app/models/**/*[1].rb', 'Model', true }, -- Ignore create entry (with true)
--      } },
--      { 'app/contracts/(.*)_contracts/(.*).rb', { { 'app/services/[1]_services/[2].rb', 'Service' } } }, -- from contracts to services
--      -- Search anything on helper folder that contains pluralize version of model.
--      --Example: app/models/user.rb -> app/helpers/foo/bar/my_users_helper.rb
--      { 'app/models/(.*).rb', { { 'db/helpers/**/*[1:pluralize]*.rb', 'Helper' } } },
--      { 'app/**/*.rb', { { 'spec/[1].rb', 'Test' } } }, -- Alternate between file and test
    },
    -- telescope_mappings = { -- Change the telescope mappings
    --   i = {
    --     open_current = '<CR>',
    --     open_horizontal = '<C-s>',
    --     open_vertical = '<C-v>',
    --     open_tab = '<C-t>',
    --   },
    --   n = {
    --     open_current = '<CR>',
    --     open_horizontal = '<C-s>',
    --     open_vertical = '<C-v>',
    --     open_tab = '<C-t>',
    --   }
    -- }
})

require('telescope').load_extension('telescope-alternate')

vim.keymap.set('n', '<leader>,', ':Telescope telescope-alternate alternate_file<cr>', {desc = '[;,] Swap/show Alternate File Mappings'})
