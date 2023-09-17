require'regexplainer'.setup {
    -- 'popup' or 'split'
    display = 'popup',
    popup = {
        border = {
            padding = {0, 0, 0, 1},
            style = 'double'
        }
    },

    -- 'narrative'
    mode = 'narrative', -- TODO: 'ascii', 'graphical'

    -- automatically show the explainer when the cursor enters a regexp
    auto = true,

    -- filetypes (i.e. extensions) in which to run the autocommand
    filetypes = {
        'html',
        'js', 'cjs', 'mjs', 'jsx',
        'ts', 'tsx', 'cjsx', 'mjsx',
        -- TODO: add java support once LSP installed
    },

    -- Whether to log debug messages
    debug = false, 

    mappings = {
        toggle = 'gR',
        -- examples, not defaults:
        -- show = 'gS',
        -- hide = 'gH',
        -- show_split = 'gP',
        -- show_popup = 'gU',
    },

    narrative = {
        separator = '\n',
    },
}
