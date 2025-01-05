--
-- LSP Completion
-- blink + colorful-menu

return {
    {
        'saghen/blink.cmp',
        version = '*',
        opts = {
            keymap = {
                preset = 'default',
                -- scroll_documentation_up and down - how to do?
                -- snippet_forward backward - how to do snippets
            },
            appearance = {
                nerd_font_variant = 'mono'
            },
            sources = {
                -- add lazydev to your completion providers
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                },
            },
            -- still experimental
            signature = {
                enabled = true,
                window = {
                    border = 'rounded'
                }
            },

            completion = {
                -- experiment with, will i find this annoying to always popup?
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                    window = {
                        border = 'rounded',
                    }
                },
                menu = {
                    draw = {
                        -- experimental
                        treesitter = { 'lsp' },
                        -- all of the components table is from colorful-menu plugin
                        components = {
                            label = {
                                width = { fill = true, max = 60 },
                                text = function(ctx)
                                    local highlights_info =
                                    require("colorful-menu").highlights(ctx.item, vim.bo.filetype)
                                    if highlights_info ~= nil then
                                        return highlights_info.text
                                    else
                                        return ctx.label
                                    end
                                end,
                                highlight = function(ctx)
                                    local highlights_info =
                                    require("colorful-menu").highlights(ctx.item, vim.bo.filetype)
                                    local highlights = {}
                                    if highlights_info ~= nil then
                                        for _, info in ipairs(highlights_info.highlights) do
                                            table.insert(highlights, {
                                                info.range[1],
                                                info.range[2],
                                                group = ctx.deprecated and "BlinkCmpLabelDeprecated" or info[1],
                                            })
                                        end
                                    end
                                    for _, idx in ipairs(ctx.label_matched_indices) do
                                        table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                                    end
                                    return highlights
                                end,
                            },
                        },
                    },
                    -- don't show completion menu when searching
                    auto_show = function(ctx)
                        return ctx.mode ~= 'cmdline' or not vim.tbl_contains({ '/', '?' }, vim.fn.getcmdtype())
                    end
                },
            },
        },
        opts_extend = { 'sources.default' }
    },

    {
        'xzbdmw/colorful-menu.nvim',
        config = function()
            -- You don't need to set these options.
            require('colorful-menu').setup({
                ft = {
                    typescript = {
                        enabled = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact' },
                    }
                }
            })
        end,
    },
}
