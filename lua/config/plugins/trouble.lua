--
-- trouble settings
--

require('trouble').setup({
    position = "bottom", -- position of the list can be: bottom, top, left, right
    severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
    padding = false, -- add an extra new line on top of the list
    cycle_results = false, -- cycle item list when reaching beginning or end of list
    multiline = false, -- render multi-line messages
    win_config = { border = "double" }, -- window configuration for floating windows. See |nvim_open_win()|.
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = true, -- automatically close the list when you have no diagnostics
    auto_preview = false, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"

    action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = { "<cr>", "<tab>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
        open_split = { "<c-s>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        switch_severity = "s", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        open_code_href = "w", -- if present, open a URI with more information about the diagnostic error
        close_folds = {"zc", "zM", "zm"}, -- close all folds
        open_folds = {"zo", "zO"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "k", -- previous item
        next = "j", -- next item
        help = "?" -- help menu
    },
})

vim.keymap.set('n', '<leader>tt', function() require('trouble').toggle() end, { desc = '[;] [T]rouble [T]oggle' })
vim.keymap.set('n', '<leader>tr', function() require('trouble').refresh() end, { desc = '[;] [T]rouble [R]efresh' })
vim.keymap.set('n', '<leader>tq', function() require('trouble').toggle('quickfix') end, { desc = '[;] [T]rouble [Q]uickfix' })
vim.keymap.set('n', 'g/', function() require('trouble').toggle('lsp_references') end, { desc = '[g/] Show LSP References' })
