-- format file with biome formatter
vim.keymap.set('n', '<tab><space>', ":silent !biome check --write '%'<cr>",
    { desc = '[<tab><space>] Format file with Biome', silent = true })
