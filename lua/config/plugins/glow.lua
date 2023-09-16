--
-- glow settings
--

require('glow').setup({
    border = 'double',
    style = 'dark'
})

vim.keymap.set('n', 'gm', ':Glow<cr>', {desc = 'Open [G]low [M]arkdown Previewer'})
