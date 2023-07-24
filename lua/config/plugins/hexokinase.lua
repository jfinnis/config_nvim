--
-- plugins/hexokinase.lua
--

-- show color at end of line
vim.g.Hexokinase_highlighters = { 'virtual' }

-- override to show after triple_hex as well
vim.g.Hexokinase_optInPatterns = 'full_hex,triple_hex,rgb,rgba,hsl,hsla,colour_names'
