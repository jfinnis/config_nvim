--
-- telescope settings
--

local telescope_mappings = {
    ['<C-k>'] = require('telescope.actions.layout').toggle_preview,
    ['<C-x>'] = false,
    ['<C-h>'] = 'select_horizontal',
    ['<S-tab>'] = false,
    ['<tab>'] = 'toggle_selection',
    ['<C-,>'] = 'results_scrolling_up',
    ['<C-.>'] = 'results_scrolling_down',
    -- open the file and resume the picker
    ['<C-o>'] = false,
    ['<C-o>o'] = function(prompt_bufnr) require('telescope.actions').select_default(prompt_bufnr) require('telescope.builtin').resume() end,
    ['<C-o>v'] = function(prompt_bufnr) require('telescope.actions').select_vertical(prompt_bufnr) require('telescope.builtin').resume() end,
    ['<C-o>h'] = function(prompt_bufnr) require('telescope.actions').select_horizontal(prompt_bufnr) require('telescope.builtin').resume() end,
}

require('telescope').setup{
    defaults = {
        prompt_prefix = ' 🔎 ',
        selection_caret = ' → ',
        multi_icon = '＋',
        dynamic_preview_title = true,
        path_display = 'smart', -- figure out
        wrap_results = false, -- maybe true for certain views
        layout_strategy = 'horizontal',
        mappings = { n = telescope_mappings, i = telescope_mappings },
        file_ignore_patterns = { '.png', '.gif', '.jpg', '.jpeg' },
    }
}

require('telescope').load_extension('fzf')
local telescope = require('telescope.builtin')
local themes = require('telescope.themes')


--
-- code search functionality
--

-- ;a - search
vim.keymap.set('n', '<leader>a', function()
    telescope.live_grep({
        prompt_title = 'Search All Files',
        disable_coordinates = true,
    })
end, {desc='[;] Search [a]ll files for string'})
-- ;A - search under cursor
vim.keymap.set('n', '<leader>A', function()
    telescope.grep_string({
        word_match = '-w',
        disable_coordinates = true
    })
end, {desc='[;] Search for ex[A]ct string under cursor'})
-- ;n - file finder
vim.keymap.set('n', '<leader>n', function()
    telescope.find_files({
        hidden = true
    })
end, {desc='[;n] Search files'})
-- ;fs - fuzzy find cur buffer
vim.keymap.set('n', '<leader>fs', function()
    telescope.current_buffer_fuzzy_find(themes.get_dropdown {
        prompt_title = 'Search Current Buffer',
        winblend = 7,
        previewer = false,
        -- TODO: how to set window options (title) to something else
    })
end, {desc='[;] [F]ind [s]earch term in current buffer'})


--
-- lsp extensions
--

-- gd - hover diagnostic in line
---- defined in lsp-zero file
-- gK - search definition of term
---- defined in lsp-zero file
-- gt - show type definition of term
---- defined in lsp-zero file
-- gy - show lsp symbols
---- defined in lsp-zero file
-- g/ - search references of term
---- defined in lsp-zero file


--
-- git extensions
--

-- TODO: can git status toggle a staged setting?
-- ;gs - git status
vim.keymap.set('n', '<leader>gs', function()
    telescope.git_status({
        prompt_title = 'Git Status (<cr> to open, <tab> to stage/unstage)'
    })
end, {desc='[;] [G]it [S]tatus'})
-- ;gS - git stash
vim.keymap.set('n', '<leader>gS', telescope.git_stash, {desc='; [G]it [S]tash'})


--
-- vim extensions
--

-- ;fb - display open buffers
vim.keymap.set('n', '<leader>fb', telescope.buffers, {desc='[F]ind Open [B]uffers'})
-- ;fc - display vim commands
vim.keymap.set('n', '<leader>fc', telescope.commands, {desc='[;] [F]ind Vim [C]ommands'})
-- ;fC - display and preview colorschemes
vim.keymap.set('n', '<leader>fC', function()
    telescope.colorscheme({
        enable_preview = true
    })
end, {desc='[;] [F]ind [C]olorschemes'})
-- ;fh - display vim help tags
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {desc='[;] [F]ind Vim [H]elp Tags'})
-- ;fH - display vim highlight groups
vim.keymap.set('n', '<leader>fH', telescope.highlights, {desc='[;] [F]ind [H]ighlight Groups'})
-- ;fk - display keymaps
vim.keymap.set('n', '<leader>fk', telescope.keymaps, {desc='[;] [F]ind [K]eymaps'})
-- ;fK - display man pages search
vim.keymap.set('n', '<leader>fK', telescope.man_pages, {desc='[;fK] Search Man Pages'})
-- ;fm - display marks
vim.keymap.set('n', '<leader>fm', telescope.marks, {desc='[;] [F]ind [M]arks'})
-- ;fo - display vim options
vim.keymap.set('n', '<leader>fo', telescope.vim_options, {desc='[;] [F]ind Vim [O]ptions'})
-- ;fq - display quickfix history
vim.keymap.set('n', '<leader>fq', telescope.quickfixhistory, {desc='[;f] Display [Q]uickfix History'})
-- ;fQ - display quickfix entries
vim.keymap.set('n', '<leader>fQ', function()
    telescope.quickfix({
        show_line = false,
        trim_text = true,
        fname_width = 30
    })
end, {desc='[;f] [F]ind [Q]uickfix Entries'})
-- ;fr - display registers
vim.keymap.set('n', '<leader>fr', telescope.registers, {desc='[;] [F]ind [R]egisters'})
-- ;fs - display spelling suggestions
vim.keymap.set('n', '<leader>fS', function()
    telescope.spell_suggest(themes.get_dropdown({
        winblend = 7
    }))
end, {desc='[;] [F]ind [S]pelling Suggestions'})
-- q: - upgraded command history
vim.keymap.set('n', 'q:', telescope.command_history, {desc='[q:] - Upgraded Command History Window'})
-- q/ - upgraded search history
vim.keymap.set('n', 'q/', telescope.search_history, {desc='[q/] - Upgraded Search History Window'})


--
-- misc
--

-- ;e - search emoji
vim.keymap.set('n', '<leader>e', function()
    telescope.symbols(themes.get_dropdown({
        sources = {'gitmoji', 'emoji'},
        winblend = 7
    }))
end, {desc='[;] Insert [E]moji'})
