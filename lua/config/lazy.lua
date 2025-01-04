-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.maplocalleader = ' '

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- Load plugin directory - each file installs itself
        { import = 'config.plugins2' },
    },

    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- check plugin updates but don't notify
    checker = { enabled = true, notify = false },
    -- don't reload config on changes
    change_detection = { enabled = false, notify = false },
}, {
    rocks = {
        hererocks = true,
    },
})

require('lazy').setup('plugins', {
    change_detection = {
        notify = false,
    },
})
