--
-- telescope settings
--
require('telescope').setup{
  defaults = {
    prompt_prefix = ' 🔎 '
  }
}
require('telescope').load_extension('fzf')


local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>n', telescope.find_files, {desc='[n] Search files'})
vim.keymap.set('n', '<leader>a', telescope.live_grep, {desc='[a] Search for string'})
vim.keymap.set('n', '<leader>A', telescope.grep_string, {desc='[A] Search for string under cursor'})
vim.keymap.set('n', '<leader>fl', telescope.diagnostics, {desc='[l] Search diagnostics'})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {desc='[F]ind open buffers'})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {desc='[F]ind VIM [h]elp tags'})
-- TODO: only in current git dir
vim.keymap.set('n', '<leader>fr', telescope.oldfiles, {desc='[?] Find recently opened files'})
vim.keymap.set('n', '<leader>fs', function()
    telescope.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, {desc='[F]ind [s]earch term in current buffer'})
