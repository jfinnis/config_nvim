--
-- marks settings
--

require'marks'.setup {
    default_mappings = true, -- default true
    mappings = {
        annotate = 'm.'
    },
    force_write_shada = true, -- delete global mark in SHAred DAta file
    bookmark_1 = {
        sign = '🧊',
        annotate = true
  }
    --   with keys: sign (emoji?)
    --              virt_text (description)
    --              annotate - prompt user for annotation
}

vim.keymap.set('n', 'm?', ':BookmarksQFListAll<CR>')

-- TODO:
-- enhance bookmarks to show emoji
-- adding a bookmark
