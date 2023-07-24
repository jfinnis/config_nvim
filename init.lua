--
-- neovim lua config
-- inspired by https://github.com/ericmurphyxyz/dotfiles/tree/master/.config/nvim
--

require('config.plugins')
require('config.settings')
require('config.keybinds')


--- reload the neovim configuration
-- required to be in this directory to reload the subdirectories
function reload_config()
  for name,_ in pairs(package.loaded) do
    if name:match('^config') then
      package.loaded[name] = nil
    end
  end

  require('config.plugins')
  require('config.settings')
  require('config.keybinds')

  -- Reload after/ directory
  local glob = vim.fn.stdpath('config') .. '/after/**/*.lua'
  local after_lua_filepaths = vim.fn.glob(glob, true, true)

  for _, filepath in ipairs(after_lua_filepaths) do
    dofile(filepath)
  end

  vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end
vim.keymap.set('n', '<leader>S', reload_config)



