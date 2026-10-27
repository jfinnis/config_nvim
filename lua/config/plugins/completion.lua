--
-- completion
-- blink
--

return {
    {
        'saghen/blink.cmp',
        version = '1.*',

        dependencies = {
            { 'rafamadriz/friendly-snippets' },
            { 'disrupted/blink-cmp-conventional-commits' },
        },

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            keymap = { preset = 'default' },

            appearance = {
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
                ghost_text = {
                    enabled = true,
                },

                -- configuring colorful-menu as the component that is rendered
                menu = {
                    draw = {
                        -- We don't need label_description now because label and label_description are already
                        -- combined together in label by colorful-menu.nvim.
                        columns = { { "kind_icon" }, { "label", gap = 1 } },
                        components = {
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                },
            },

            sources = {
                default = { 'conventional_commits', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    conventional_commits = {
                        name = 'Conventional Commits',
                        module = 'blink-cmp-conventional-commits',
                        enabled = function()
                            return vim.bo.filetype == 'gitcommit'
                        end,
                        ---@module 'blink-cmp-conventional-commits'
                        ---@type blink-cmp-conventional-commits.Options
                        opts = {
                            -- See Configuration section below for available options
                        },
                    },
                },
            },

            fuzzy = { implementation = "rust" },

            -- auto show function signature, <c-k> to toggle
            signature = {
                enabled = true,
                window = {
                    show_documentation = true,
                }
            },
        },
        opts_extend = { 'sources.default' }
    },

    {
        'xzbdmw/colorful-menu.nvim',
        config = function()
            require('colorful-menu').setup({
                -- ft = {
                --     typescript = {
                --         enabled = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
                --     }
                -- }
            })
        end,
    },
}
