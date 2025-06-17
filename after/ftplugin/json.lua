-- add comma when hitting o for new line
vim.keymap.set('n', 'o', function()
    local line = vim.api.nvim_get_current_line()

    local should_add_comma = string.find(line, '[^,{[]$')
    if should_add_comma then
        return 'A,<cr>'
    else
        return 'o'
    end
end, { buffer = true, expr = true })

vim.keymap.set('n', '<tab><space>', ':lua vim.lsp.buf.format({ async = true })<cr>',
    { desc = '[<tab><space>] Format the entire file', silent = true })
