-- format file with kulala formatter
vim.keymap.set('n', '<tab><space>', ':silent !kulala-fmt format "%"<cr>',
    { desc = '[<tab><space>] Format file with Kulala-fmt', silent = true })
