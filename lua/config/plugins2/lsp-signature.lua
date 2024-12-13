--
-- lsp-signature - show function signatures while editing
--

return {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    config = function()
        require 'lsp_signature'.setup {}
    end
}
