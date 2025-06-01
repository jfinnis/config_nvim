--
-- switch settings
--

return {
   'AndrewRadev/switch.vim',
   config = function()
      -- default keybind is `gs`
      vim.g.switch_custom_definitions = {
         { '==', '!=' },
         { '===', '!==' },
         { 'disabled', 'enabled' },
         { 'Disabled', 'Enabled' },
         { 'toBeTruthy', 'toBeFalsy' },
         { '"', "'" },
         { 'white', 'black' },
      }
   end
}

-- not needed anymore, but an example of buffer specific definitions
--autocmd FileType text let b:switch_custom_definitions = [
--\   [ '-', '+', '?' ]
--\ ]
