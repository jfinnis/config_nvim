--
-- telescope-file-browser settings
--

local fb_actions = require'telescope'.extensions.file_browser.actions

require('telescope').setup {
  extensions = {
    file_browser = {
      display_stat = { 'date', 'size' },
      grouped = true,
      hidden = true,
      hijack_netrw = true,
      mappings = {
        ['n'] = {
          ['ss'] = fb_actions.sort_by_size,
          ['sd'] = fb_actions.sort_by_date
        }
      },
      depth = 1
    }
  } 
}

require('telescope').load_extension 'file_browser'

vim.keymap.set('n', '<leader>N', ':Telescope file_browser<cr>', {desc = '[;N] Open File Browser'})
