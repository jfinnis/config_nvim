--
-- keybinds.lua
--

-----------------------
--   misc functions  --
-----------------------
-- run current lua line (useful for editing nvim config)
vim.keymap.set('n', '<leader>x', ':.lua<cr>', { desc = '[;] E[x]ecute current line (lua)' })
vim.keymap.set('v', '<leader>x', ':lua<cr>', { desc = '[;] E[x]ecute current line (lua)' })

-- fold all folds recursively
vim.keymap.set('n', 'zn', 'zR')

-- indent the just pasted text
vim.keymap.set('n', '<leader>>', "g'[>']")
vim.keymap.set('n', '<leader><', "g'[<']")

-- insert row of hyphens matching length of prev line
vim.keymap.set('i', '', '<esc>yypv$r-o')

-- remove all trailing whitespace
vim.keymap.set('n', '<leader>W', ":%s/\\s\\+$//<cr>:let @/=''<cr>:echo 'Removed trailing whitespace'<cr>")

-- split line at the current cursor position
vim.keymap.set('n', 'S', 'i<cr><esc>')

-- yank to system clipboard
vim.keymap.set({'n', 'v'}, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-----------------------
-- window management --
-----------------------
-- open alternative buffer
vim.keymap.set('n', '<Leader>#', ':e #<cr>')

-- set window to max size and same size
vim.keymap.set('n', '+', '<C-w>_')
vim.keymap.set('n', '_', '<C-w>=')

-----------------------
--    completion     --
-----------------------
-- reuse tab for completions, hit twice for a real tab
vim.keymap.set('i', '<tab><tab>', '<tab>')

-- omnicomplete
vim.keymap.set('i', '<tab>o', '<C-X><C-O>')

-- complete whole lines
vim.keymap.set('i', '<tab>l', '<C-X><C-L>')

-- complete file names
vim.keymap.set('i', '<tab>f', '<C-X><C-F>')

-- next and previous are less useful when LSP is used but has some uses outside
-- of that, e.g.: comments
-- next completion
vim.keymap.set('i', '<tab>n', '<C-X><C-N>')

-- previous completion
vim.keymap.set('i', '<tab>p', '<C-X><C-P>')

-- complete identifiers from dictionary
vim.opt.dictionary:append('/usr/share/dict/words')
vim.keymap.set('i', '<tab>k', '<C-X><C-K>')

-- complete identifiers from thesaurus
vim.opt.thesaurus:append('~/.config/nvim/mthesaur.txt')
vim.keymap.set('i', '<tab>t', '<C-X><C-T>')
