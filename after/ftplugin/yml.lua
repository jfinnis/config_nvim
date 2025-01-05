vim.keymap.set('n', '<tab><space>', ':lua vim.lsp.buf.format({ async = true })<cr>',
    { desc = '[<tab><space>] Format the entire file' })
