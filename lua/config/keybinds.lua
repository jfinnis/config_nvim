--
-- keybinds.lua
--

-----------------------
--       colors      --
-----------------------
function ToggleColorScheme()
    local color
    --if vim.g.colors_name ~= 'rose-pine-moon' and vim.g.colors_name ~= 'rose-pine' then
        --color = 'rose-pine-moon'
    if vim.g.colors_name ~= 'terafox' then
        color = 'terafox'
    else
        color = 'dayfox'
    end
    vim.cmd.colorscheme(color)
end
vim.keymap.set('n', '<leader>C', ToggleColorScheme, {desc = '[;cc] Toggle light/dark colorscheme'})
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = 'antiquewhite' })
vim.cmd[[highlight Comment gui=italic]]


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

-- move between windows
vim.keymap.set('n', '<Leader>h', '<C-W>h') -- left
vim.keymap.set('n', '<Leader>j', '<C-W>j') -- down
vim.keymap.set('n', '<Leader>k', '<C-W>k') -- up
vim.keymap.set('n', '<Leader>l', '<C-W>l') -- right

-- resize left/right/up/down
vim.keymap.set('n', '<C-W><', '<C-W><:let g:LastWindowResize="in-horiz"<cr>', { silent = true })
vim.keymap.set('n', '<C-W>>', '<C-W>>:let g:LastWindowResize="out-horiz"<cr>', { silent = true })
vim.keymap.set('n', '<C-W>+', '<C-W>+:let g:LastWindowResize="out-vert"<cr>', { silent = true })
vim.keymap.set('n', '<C-W>-', '<C-W>-:let g:LastWindowResize="in-vert"<cr>', { silent = true })

-- repeat last resize with comma ','
vim.cmd([[
function! RepeatResize()
    if exists("g:LastWindowResize")
        if match(g:LastWindowResize, "in-horiz") == 0
            normal! <
        elseif match(g:LastWindowResize, "out-horiz") == 0
            normal! >
        elseif match(g:LastWindowResize, "out-vert") == 0
            normal! +
        else
            normal! -
        endif
    endif
endfunction
]])
vim.keymap.set('n', ',', ':call RepeatResize()<cr>', { silent = true })

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
