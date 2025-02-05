--
-- settings.lua
--
vim.g.mapleader = ';'

vim.opt.backupcopy = 'yes' -- will create a backup file instead of renaming the file
                           -- needed for vite dev server which was having issues watching changes
vim.opt.conceallevel = 2 -- use replacement character for concealed text
vim.opt.diffopt = 'internal,filler,closeoff,linematch:60'
vim.opt.gdefault = true -- replace all occurrences in line for :s///
vim.opt.list = true -- show chars for end of line
--vim.opt.listchars:append 'eol:↴'
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.scrolloff = 4 -- lines above/below cursor while scrolling
vim.opt.shortmess = 'filmnxtTIoOF' -- experiment with I above, hides intro (try with alpha-nvim)
vim.opt.signcolumn = 'auto' -- only display when there's a sign to display
vim.opt.timeoutlen = 500 -- shorter timeout for mappings (milliseconds)
vim.opt.title = true -- terminal window shows name of file - doesn't work in tmux?
vim.opt.termguicolors = true -- advanced colors required for hexokinase plugin
vim.opt.updatetime = 1000 -- write swapfile to disk after these milliseconds
vim.opt.undofile = true
vim.opt.wildmode = 'longest:full' -- command completion to longest substring, then show popup menu of completions

-- display stuff
vim.opt.colorcolumn = '100' -- highlight these columns in different color
vim.opt.cursorcolumn = false
vim.opt.cursorline = false

-- cursor line displays only in active window
local cursorGroup = vim.api.nvim_create_augroup('CursorLine', {clear = true})
vim.api.nvim_create_autocmd(
    { 'InsertEnter', 'WinLeave' },
    { pattern = '*', command = 'set nocursorline nocursorcolumn', group = cursorGroup }
)

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd('VimResized', {
    command = 'wincmd =',
})

-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.cmd('normal! g`"zz')
        end
    end,
})
 
-- -- only show command line when typing a command
-- vim.o.cmdheight = 0
-- vim.api.nvim_create_autocmd('CmdlineEnter', {
--     group = vim.api.nvim_create_augroup(
--         'gmr_cmdheight_1_on_cmdlineenter',
--         { clear = true }
--     ),
--     desc = 'Don\'t hide the status line when typing a command',
--     command = ':set cmdheight=1',
-- })
-- 
-- vim.api.nvim_create_autocmd('CmdlineLeave', {
--     group = vim.api.nvim_create_augroup(
--         'gmr_cmdheight_0_on_cmdlineleave',
--         { clear = true }
--     ),
--     desc = 'Hide cmdline when not typing a command',
--     command = ':set cmdheight=0',
-- })
-- 
-- vim.api.nvim_create_autocmd('BufWritePost', {
--     group = vim.api.nvim_create_augroup(
--         'gmr_hide_message_after_write',
--         { clear = true }
--     ),
--     desc = 'Get rid of message after writing a file',
--     pattern = { '*' },
--     command = 'redrawstatus',
-- })

-- set local settings for terminal buffers
vim.api.nvim_create_autocmd('TermOpen', {
    pattern = 'term://*',
    callback = function()
        if vim.opt.buftype:get() == 'terminal' then
            local set = vim.opt_local
            set.number = false
            set.relativenumber = false
            set.scrolloff = 0
            vim.opt.filetype = 'terminal'

            vim.cmd.startinsert() -- start in insert mode
        end
    end,
})

-- highlight yanked text briefly - replaced with Tiny Glimmer plugin for animated yank
-- vim.api.nvim_create_augroup('YankHighlight', {clear = true})
-- vim.api.nvim_create_autocmd('TextYankPost', {
--     group = 'YankHighlight',
--     callback = function()
--         vim.highlight.on_yank({higroup = 'IncSearch', timeout = '200'})
--     end
-- })

-- search
vim.opt.hlsearch = true -- highlight every match, clear with <C-l>
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- ... unless capitals are included

-- text formatting
vim.opt.expandtab = true -- convert tab presses to spaces
vim.opt.formatoptions = 'cro/q1jl'
vim.opt.linebreak = true -- don't wrap in middle of words
vim.opt.textwidth = 120
vim.opt.virtualedit = 'block' -- position cursor where there is no char in block mode

vim.opt.shiftwidth = 4 -- spaces used during (auto)indent, >>, and <<
vim.opt.tabstop = 4 -- tabs are 4 spaces, can be overridden per filetype

vim.opt.showmatch = true -- when inserting bracket/paren, highlight matching one
vim.opt.matchtime = 3 -- tenths of a second

-- enable undercurl support
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- enable spell check
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }

-- allow closing windows with 'q' that normally require ':q'
vim.api.nvim_create_autocmd(
    'FileType',
    {
        pattern = {'help', 'qf', 'lspinfo', 'startuptime', 'man', 'checkhealth', 'lazy'},
        command = [[
            nnoremap <buffer><silent> q :close<cr>
            set nobuflisted
        ]]
    }
)

-- show line numbers for help files
vim.api.nvim_create_autocmd(
    'FileType',
    {
        pattern = {'help'},
        command = 'set number'
    }
)

-- center screen when searching, folding, and navigating to marks
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', 'zc', 'zczz')
vim.keymap.set('n', 'zo', 'zozz')
vim.cmd[[
  :for m in map(map(range(10), 'nr2char(48+v:val)'), '"nnoremap ''".v:val." ''".v:val."zz"') | exe m | endfor
]]
vim.cmd[[
  :for m in map(map(range(26), 'nr2char(65+v:val)'), '"nnoremap ''".v:val." ''".v:val."zz"') | exe m | endfor
]]
vim.cmd[[
  :for m in map(map(range(26), 'nr2char(97+v:val)'), '"nnoremap ''".v:val." ''".v:val."zz"') | exe m | endfor
]]

-----------------------
--       utils       --
-----------------------
-- util for creating :ex command aliases for common typos
vim.cmd([[
function! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
    \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
    \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction
-]])
vim.cmd('call SetupCommandAlias("Vs", "vs")')
vim.cmd('call SetupCommandAlias("Qa", "qa")')
vim.cmd('call SetupCommandAlias("Qa!", "qa!")')
