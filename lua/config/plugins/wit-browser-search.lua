return {
    'aliqyan-21/wit.nvim',
    config = function()
        require("wit").setup({
            -- You can choose your preferred search engine from
            -- the supported list: {google, bing, duckduckgo, ecosia, brave, perplexity}.
            --
            -- There's also the possibility of just specifying a custom
            -- search engine URL by providing the base URL and the required search params.
            -- EXAMPLE:
            -- engine = "https://<your_preferred_search_engine>/search?q="
            engine = 'perplexity', -- search engine (default: "google")

            command_search = 'WitSearch', -- custom command to search (default: "WitSearch")
            command_search_visual = 'WitSearchVisual', -- custom command to search visually (default: "WitSearchVisual")
            command_search_wiki = 'WitSearchWiki', -- custom command to search wikipedia (default: "WitSearchWiki"),

        })

        vim.keymap.set('v', '<leader>fw', ':WitSearchVisual<cr>', { desc = '[;] [F]ind on the [W]eb' })
        vim.keymap.set('n', '<leader>fW', ':WitSearch ', { desc = '[;] [F]ind on the [W]eb' })
end
}
