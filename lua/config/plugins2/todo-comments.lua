--
-- todo comment highlighter
--

return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('todo-comments').setup {
            -- use all defaults
            -- keywords = {
            --     FIX = {
            --         icon = " ", -- icon used for the sign, and in search results
            --         color = "error", -- can be a hex color, or a named color (see below)
            --         alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            --         -- signs = false, -- configure signs for some keywords individually
            --     },
            --     TODO = { icon = " ", color = "info" },
            --     HACK = { icon = " ", color = "warning" },
            --     WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
            --     PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            --     NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
            --     TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            -- },
            -- list of named colors where we try to extract the guifg from the
            -- list of highlight groups or use the hex color if hl not found as a fallback
            colors = {
                -- error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                error = { "#D0342C" },
                warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
                -- info = { "DiagnosticInfo", "#2563EB" },
                info = { "#FF00FF" },
                hint = { "#10B981" },
                -- hint = { "DiagnosticHint", "#10B981" },
                default = { "Identifier", "#7C3AED" },
                test = { "Identifier", "#FF00FF" }
            },
            highlight = {
                multiline = true, -- enable multine todo comments
                multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
                multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
                before = "fg", -- "fg" or "bg" or empty
                keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                after = "fg", -- "fg" or "bg" or empty
                pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
                comments_only = true, -- uses treesitter to match keywords in comments only
                max_line_len = 400, -- ignore lines longer than this
                exclude = {}, -- list of file types to exclude highlighting
            },
        }

        vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "[]t] Next todo comment" })
        vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "[[t] Previous todo comment" })
    end
}
