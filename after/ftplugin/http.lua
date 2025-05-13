-- <cr> to run request
vim.api.nvim_buf_set_keymap(
    0,
    'n',
    '<CR>',
    '<cmd>lua require("kulala").run()<cr>',
    { noremap = true, silent = true, desc = '<CR> Run request' }
)

-- <shift><cr> to run all requests
vim.api.nvim_buf_set_keymap(
    0,
    'n',
    '<s-CR>',
    '<cmd>lua require("kulala").run_all()<cr>',
    { noremap = true, silent = true, desc = 'Shift+<CR> Run all requests' }
)

-- [r and ]r prev/next
vim.api.nvim_buf_set_keymap(
    0,
    'n',
    '[r',
    '<cmd>lua require("kulala").jump_prev()<cr>',
    { noremap = true, silent = true, desc = '\'[\' Previous [R]equest' }
)
vim.api.nvim_buf_set_keymap(
    0,
    'n',
    ']r',
    '<cmd>lua require("kulala").jump_next()<cr>',
    { noremap = true, silent = true, desc = '\']\' Next [R]equest' }
)

-- <leader>p to paste from curl
vim.api.nvim_buf_set_keymap(
    0,
    'n',
    '<leader>p',
    '<cmd>lua require("kulala").from_curl()<cr>',
    { noremap = true, silent = true, desc = '[;] [P]aste Curl' }
)
vim.api.nvim_buf_set_keymap(
    0,
    'n',
    '<leader>c',
    '<cmd>lua require("kulala").copy()<cr>',
    { noremap = true, silent = true, desc = '[;] [C]opy as Curl' }
)

-- format file with kulala formatter
vim.keymap.set('n', '<tab><space>', ":silent !kulala-fmt format '%'<cr>",
    { desc = '[<tab><space>] Format file with Kulala-fmt', silent = true })
