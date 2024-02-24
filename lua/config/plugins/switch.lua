--
-- switch settings
--

vim.g.switch_mapping = '-'
vim.g.switch_custom_definitions = {
   { '==', '!=' },
   { '===', '!==' },
   { 'disabled', 'enabled' },
   { 'Disabled', 'Enabled' },
   { '"', "'" },
   { 'white', 'black' },
}

-- not needed anymore, but an example of buffer specific definitions
--autocmd FileType text let b:switch_custom_definitions = [
--\   [ '-', '+', '?' ]
--\ ]
