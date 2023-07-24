--
-- treesitter settings
--

require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all"
    ensure_installed = { "javascript", "typescript", "bash", "java", "lua", "html", "json", "c", "vim", "vimdoc", "query", "make", "comment", "css", "diff", "dockerfile", "go", "graphql", "python", "ruby", "sql", "yaml", "gitignore", "gitcommit", "git_config" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- Need to enable the modules because they're disabled by default.
    highlight = {
        enable = true
        -- disable accepts list of languages or a function
        --disable = function(lang, bufnr) -- Disable in large C++ buffers
        --    return lang == "cpp" and vim.api.nvim_buf_line_count(bufnr) > 50000
        --end,
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            scope_incremental = 'v',
        }
    },

    textobjects = {
        enable = true
    },

    indent = {
        enable = true
    }
}

-- need to set here to override vim's visual => visual-line mode
vim.keymap.set('v', 'V', ":lua require'nvim-treesitter.incremental_selection'.node_decremental()<cr>")

-- Workaround for error "No folds found" that sometimes occurs
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/1469#issuecomment-1141662730
vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
    group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
    callback = function()
        vim.opt.foldmethod     = 'expr'
        vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
    end
})
