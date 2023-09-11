--
-- telescope-neoclip settings
--
--

require('neoclip').setup({
    enable_macro_history = false,
    keys = {
    telescope = {
        i = {
            --select = '<cr>',
            paste = '<c-.>',
            paste_behind = '<c-,>',
            --replay = '<c-q>',  -- replay a macro
            --delete = '<c-d>',  -- delete an entry
            --edit = '<c-e>',  -- edit an entry
            --custom = {},
      }
    }
  }
})

require('telescope').load_extension('neoclip')

vim.keymap.set('n', '<leader>fy', ':Telescope neoclip<cr>', {desc = '[;] [F]ind [Y]ank History'})
