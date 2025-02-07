--
-- oil - file explorer
--

-- for toggling file detail view
local detail = false

-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
    local dir = require("oil").get_current_dir()
    if dir then
        return vim.fn.fnamemodify(dir, ":~")
    else
        -- If there is no current directory (e.g. over ssh), just show the buffer name
        return vim.api.nvim_buf_get_name(0)
    end
end

return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    lazy = false,
    config = function()
        require('oil').setup({
            columns = { 'icon' },
            keymaps = {
                ['<leader><esc>'] = { 'actions.close', mode = 'n' },
                ['gd'] = {
                    desc = 'Toggle file detail view',
                    callback = function()
                        detail = not detail
                        if detail then
                            require('oil').set_columns({ 'icon', 'permissions', 'size', 'mtime' })
                        else
                            require('oil').set_columns({ 'icon' })
                        end
                    end,
                },
            },
            view_options = {
                show_hidden = true,
            },
            -- This function defines what will never be shown, even when `show_hidden` is set
            is_always_hidden = function(name, bufnr)
                return false
            end,
            -- Customize the highlight group for the file name
            highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
                return nil
            end,
            git = {
                -- Return true to automatically git add/mv/rm files
                add = function(path)
                    return false
                end,
                mv = function(src_path, dest_path)
                    return true
                end,
                rm = function(path)
                    return true
                end,
            },
            preview_win = {
                -- A function that returns true to disable preview on a file e.g. to avoid lag
                -- TODO: this is not working?
                disable_preview = function(filename)
                    print('hifhdsif   ' .. filename)
                    return filename == 'package-lock.json'
                        or filename == 'mthesaur.txt'
                end,
            },
            float = { border = 'double' },
            confirmation = { border = 'double' },
            progress = { border = 'double' },
            keymaps_help = { border = 'double' },
            win_options = {
                winbar = "%!v:lua.get_oil_winbar()",
            },
        })

        vim.keymap.set('n', '-', ':Oil<cr>', { desc = '[-] Open parent directory' })
    end,
}
