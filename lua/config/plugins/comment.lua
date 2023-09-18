--
-- comment settings
--

require('Comment').setup({
    padding = true,
    sticky = true,
    ignore = nil,
    toggler = { line = ';cc', block = ';bc' },
    opleader = { line = ';c', block = ';b' },
    extra = { above = ';cO', below = ';co', eol = ';cA' },
    mappings = { basic = true, extra = true },
    pre_hook = nil,
    post_hook = nil,
})
