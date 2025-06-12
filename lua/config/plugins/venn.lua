--
-- venn.nvim - fancy ascii diagrams
--

-- Note: yov mapping from unimpaired also toggles virtualEdit mode
-- Hydra.nvim is also recommended for modal keymaps but let's see how this works.

-- venn.nvim: enable or disable keymappings and vritual edit mode
function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd[[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true, silent = true })
        -- draw a box by pressing "b" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "b", ":VBox<CR>", { noremap = true, silent = true})
        -- draw with overlap
        vim.api.nvim_buf_set_keymap(0, "v", "B", ":VBoxO<CR>", { noremap = true, silent = true})
        -- double line box
        vim.api.nvim_buf_set_keymap(0, "v", "d", ":VBoxD<CR>", { noremap = true, silent = true})
        -- double line with overlap
        vim.api.nvim_buf_set_keymap(0, "v", "D", ":VBoxDO<CR>", { noremap = true, silent = true})
        -- heavy line box
        vim.api.nvim_buf_set_keymap(0, "v", "t", ":VBoxH<CR>", { noremap = true, silent = true})
        -- heavy line box with overlap
        vim.api.nvim_buf_set_keymap(0, "v", "T", ":VBoxHO<CR>", { noremap = true, silent = true})
        -- filled box
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VFill<CR>", { noremap = true, silent = true})
    else
        vim.cmd[[setlocal ve=]]
        vim.api.nvim_buf_del_keymap(0, "n", "J")
        vim.api.nvim_buf_del_keymap(0, "n", "K")
        vim.api.nvim_buf_del_keymap(0, "n", "L")
        vim.api.nvim_buf_del_keymap(0, "n", "H")
        vim.api.nvim_buf_del_keymap(0, "n", "b")
        vim.api.nvim_buf_del_keymap(0, "n", "B")
        vim.api.nvim_buf_del_keymap(0, "n", "d")
        vim.api.nvim_buf_del_keymap(0, "n", "D")
        vim.api.nvim_buf_del_keymap(0, "n", "t")
        vim.api.nvim_buf_del_keymap(0, "n", "T")
        vim.api.nvim_buf_del_keymap(0, "v", "f")
        vim.b.venn_enabled = nil
    end
end
-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>V', ":lua Toggle_venn()<CR>",
    { noremap = true, silent = true, desc = '[;] Toggle [V]enn diagram mode' })

return {
    'jbyuki/venn.nvim',
}
