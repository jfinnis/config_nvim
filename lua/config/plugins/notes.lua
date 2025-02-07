--
-- neorg - orgmode for Neovim
-- neorg-contexts - treesitter-contexts clone
-- neorg-interim-ls - lsp for completion
-- neorg-extras - extra folding support
-- neorg-se - full text search
-- note2cal - create calendar items from text
--

-- helper functions for neorg templates
local function buffer_is_empty()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    return #lines == 0 or (#lines == 1 and lines[1] == "")
end

local function parse_weather_day(filename)
    -- filter the weather for today's and tomorrow's dates only
    local today = tostring(os.date('%Y/%m/%d'))
    local timestamp = os.date('*t')
    local raw_tomorrow = os.time({
        year = timestamp.year,
        month = timestamp.month,
        day = timestamp.day + 1
    })
    local tomorrow = tostring(os.date('%Y/%m/%d', raw_tomorrow))

    if string.find(filename, today) then
        return 'today'
    elseif string.find(filename, tomorrow) then
        return 'tomorrow'
    else
        return ''
    end
end

local function substitute_weather_output(output)
    -- substitute neorg special chars
    output = output:gsub('\\', '\\\\')
    output = output:gsub('`', '\\`')
    output = output:gsub('-', '\\-')

    -- bold the date. due to lua regex quirks, can't combine non-capturing groups with
    -- options so specify individually
    output = output:gsub('(Sun %d+ %a+)', '*%1*')
    output = output:gsub('(Mon %d+ %a+)', '*%1*')
    output = output:gsub('(Tue %d+ %a+)', '*%1*')
    output = output:gsub('(Wed %d+ %a+)', '*%1*')
    output = output:gsub('(Thu %d+ %a+)', '*%1*')
    output = output:gsub('(Fri %d+ %a+)', '*%1*')
    output = output:gsub('(Sat %d+ %a+)', '*%1*')
    return output
end

return {
    {
        dir = '~/Documents/projects/note2cal.nvim',
        -- 'lfilho/note2cal.nvim',
        config = function()
            require('note2cal').setup({
                debug = false, -- if true, prints a debug message an return early (won't schedule events)
                calendar_name = 'Me@gmail', -- the name of the calendar as it appear on Calendar.app
                highlights = {
                    at_symbol = 'WarningMsg', -- the highlight group for the "@" symbol
                    at_text = 'Number', -- the highlight group for the date-time part
                },
                keymaps = {
                    normal = '<Leader>e', -- mnemonic: Schedule [E]vent
                    visual = '<Leader>e', -- mnemonic: Schedule [E]vent
                },
            })
        end,
        ft = 'norg', -- TODO: keymaps not mapped in neorg files
    },

    {
        'nvim-neorg/neorg',
        lazy = false,
        dependencies = {
            'nvim-treesitter',
            'nvim-lua/plenary.nvim',
            'nvim-neorg/neorg-telescope',
            'nvim-neorg/tree-sitter-norg',
            'nvim-neorg/lua-utils.nvim',
            'max397574/neorg-contexts',
            'benlubas/neorg-interim-ls',
            'juniorsundar/neorg-extras',
            'benlubas/neorg-se',
        },
        version = "*",
        config = function()
            require("neorg").setup {
                load = {
                    ['core.integrations.telescope'] = {}, -- sets up telescope
                    ['core.defaults'] = {}, -- loads default behavior
                    ['core.completion'] = {
                        config = { engine = { module_name = 'external.lsp-completion' } },
                    },
                    ['core.concealer'] = {  -- adds pretty icons to documents
                        config = {
                            icon_preset = 'diamond',
                            icons = {
                                todo = {
                                    on_hold = {
                                        icon = '⏸︎'
                                    },
                                    cancelled = {
                                        icon = '✘'
                                    },
                                }
                            }
                        }
                    },
                    ['core.dirman'] = { -- manages neorg workspaces
                        config = {
                            workspaces = {
                                notes = '~/Documents/neorg',
                            },
                            default_workspace = 'notes',
                        },
                    },
                    ['core.esupports.metagen'] = {
                        config = {
                            author = 'josh',
                            update_date = false, -- TODO: would like to set to
                            -- true but having autosave issues
                            -- undojoin_updates = true -- Must be paired with
                            -- undo/redo autosave
                        }
                    },
                    ['core.summary'] = {},
                    ['core.keybinds'] = {
                        config = {
                            hook = function(keybinds)
                                -- TODO: these undo/redo fixes for autosave only seem to work one single time
                                -- will disable updating date for now
                                -- vim.keymap.set('n', 'u', function()
                                --     require('neorg.modules').get_module('core.esupports.metagen').skip_next_update()
                                --     local k = vim.api.nvim_replace_termcodes('u<c-o>', true, false, true)
                                --     vim.api.nvim_feedkeys(k, 'n', false)
                                -- end)
                                -- vim.keymap.set('n', '<C-r>', function()
                                --     require('neorg.modules').get_module('core.esupports.metagen').skip_next_update()
                                --     local k = vim.api.nvim_replace_termcodes('<c-r><c-o>', true, false, true)
                                --     vim.api.nvim_feedkeys(k, 'n', false)
                                -- end)
                            end,
                        }
                    },
                    ['core.text-objects'] = {},
                    ['core.looking-glass'] = {},
                    -- disabled - due for rewrite
                    -- ['core.presenter'] = {
                    --     config = {
                    --         zen_mode = 'zen-mode'
                    --     }
                    -- },
                    -- treesitter-like context for headings
                    ['external.context'] = {},
                    -- lsp completion for filenames and headings
                    -- allows renamed headings and filenames (oil) to be updated
                    ['external.interim-ls'] = {},
                    -- folding
                    ['external.many-mans'] = {
                        config = {
                            metadata_fold = true, -- If want @data property ... @end to fold
                            code_fold = true, -- If want @code ... @end to fold
                        }
                    },
                    -- search categories and full notes texts
                    ['external.search'] = {
                        config = {
                            -- Index the workspace when neovim launches. This process happens on a
                            -- separate thread, so it doesn't significantly contribute to startup
                            -- time or block neovim.
                            index_on_start = true,
                        }
                    },
                },
            }

            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'norg',
                callback = function()
                    -- don't expand concealed links unless you're in insert mode
                    vim.opt.concealcursor = 'nc'

                    -- searching
                    -- <space>f - telescope finder for neorg notes
                    -- located in telescope file
                    vim.keymap.set('n', '<LocalLeader>C', ':Neorg search query categories<cr>',
                        { desc = '[<space>] Search [C]ategories', buffer = true })
                    vim.keymap.set('n', '<LocalLeader>F', ':Neorg search query fulltext<cr>',
                        { desc = '[<space>] Search [F]ulltext Across Notes', buffer = true })

                    -- basic navigation
                    vim.keymap.set('n', '<LocalLeader>nr', ':Neorg return<cr>',
                        { desc = '[<space>] [N]eorg: [R]eturn', buffer = true })
                    vim.keymap.set('n', '<LocalLeader>c', ':Neorg toc<cr>',
                        { desc = '[<space>] Neorg: Table of [C]ontents', buffer = true })
                    -- <space>i - neorg insert link
                    vim.keymap.set('n', '<LocalLeader>i', ':Telescope neorg insert_link<cr>',
                        { desc = '[<space>] Neorg: [I]nsert Link', buffer = true })
                    -- <space>/ - neorg search backlinks (references)
                    vim.keymap.set('n', '<LocalLeader>/', ':Telescope neorg find_backlinks<cr>',
                        { desc = '[<space>/] Neorg: Search Backlinks', buffer = true })

                    -- <space>m - inject metadata
                    vim.keymap.set('n', '<LocalLeader>m', ':Neorg inject-metadata<cr>',
                        { desc = '[<space>] Add Neorg [M]etadata', buffer = true })

                    -- text object mappings
                    vim.keymap.set('n', '<LocalLeader>k', '<Plug>(neorg.text-objects.item-up)',
                        { desc = '[<space>k] Neorg: Move heading level down', buffer = true })
                    vim.keymap.set('n', '<LocalLeader>j', '<Plug>(neorg.text-objects.item-down)',
                        { desc = '[<space>j] Neorg: Move heading level up', buffer = true })
                    vim.keymap.set({ 'o', 'x' }, 'ih', '<Plug>(neorg.text-objects.textobject.heading.inner)',
                        { desc = '[ih] Text Object: Neorg heading', buffer = true })
                    vim.keymap.set({ 'o', 'x' }, 'ah', '<Plug>(neorg.text-objects.textobject.heading.outer)',
                        { desc = '[ah] Text Object: Neorg heading', buffer = true })

                    -- code block magnify (edit in own tmp buffer)
                    -- TODO: doesn't work?
                    -- vim.keymap.set('n', '<LocalLeader>z', ':Neorg keybind all core.looking-glass.magnify-code-block<cr>', { desc = '[<space>] [Z]oom code block to own buffer', buffer = true })

                    -- journal bindings - if the filename includes neorg/journal then do the steps
                    local filename = vim.fn.expand('%')
                    if string.find(filename, 'neorg/journal') then
                        -- only add template if the file is empty
                        if buffer_is_empty() then
                            local day = parse_weather_day(filename)
                            if day == 'today' or day == 'tomorrow' then
                                local url, lines_to_skip
                                -- pull weather text with minimal options
                                if day == 'today' then
                                    url = '"https://wttr.in/arden+nc?1nAQFdT"'
                                    lines_to_skip = 6
                                else
                                    url = '"https://wttr.in/arden+nc?2nAQFdT"'
                                    lines_to_skip = 16
                                end

                                local output = vim.fn.system('curl -s ' .. url)
                                output = substitute_weather_output(output)

                                -- hide top current weather report
                                local output_lines = vim.list_slice(vim.split(output, '\n'), lines_to_skip)

                                -- add default template
                                table.insert(output_lines, 'Dinner: \\<dinner plans\\>')
                                table.insert(output_lines, '')
                                table.insert(output_lines, '* Done')
                                table.insert(output_lines, '- ')
                                table.insert(output_lines, '')
                                table.insert(output_lines, '')
                                table.insert(output_lines, '* Todo')
                                table.insert(output_lines, '- ')
                                table.insert(output_lines, '')
                                vim.api.nvim_buf_set_lines(0, 0, -1, false, output_lines)
                            end
                        end
                    end

                    vim.wo.foldlevel = 99 -- overriding value of 7
                    --vim.wo.conceallevel = 2 -- set in settings.lua
                end
            })

            -- custom neorg wrap settings for when long links make the lines wrap
            local orig_formatlistpat = vim.opt.formatlistpat
            vim.api.nvim_create_autocmd('BufEnter', {
                pattern = '*.norg',
                callback = function()
                    vim.opt.wrap = false
                    vim.opt.breakindent = true
                    vim.opt.breakindentopt = 'list:-1'
                    vim.opt.formatlistpat = '^\\s*[-~>]\\+\\s\\((.)\\s\\)\\?'
                end
            })
            vim.api.nvim_create_autocmd('BufLeave', {
                pattern = '*.norg',
                callback = function()
                    -- restore the original wrap settings
                    vim.opt.wrap = true
                    vim.opt.breakindent = false
                    vim.opt.breakindentopt = ''
                    vim.opt.formatlistpat = orig_formatlistpat
                end
            })

            -- can be called outside neorg files to start the Neorg interface
            vim.keymap.set('n', '<Leader>I', ':Neorg index<cr>',
                { desc = '[<space>] Open Neorg [I]ndex' })

            -- journal mappings
            vim.keymap.set('n', '<Leader>JJ', ':Neorg journal today<cr>',
                { desc = '[<Leader>] Neorg: [J]ournal [J]Today' })
            vim.keymap.set('n', '<Leader>JT', ':Neorg journal tomorrow<cr>',
                { desc = '[<Leader>] Neorg: [J]ournal [T]omorrow' })
            vim.keymap.set('n', '<Leader>JY', ':Neorg journal yesterday<cr>',
                { desc = '[<Leader>] Neorg: [J]ournal [Y]esterday' })
            vim.keymap.set('n', '<Leader>JC', ':Neorg journal custom<cr>',
                { desc = '[<Leader>] Neorg: [J]ournal [C]ustom' })
        end
    },
}
