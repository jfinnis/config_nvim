
return {
    {
        'saghen/blink.cmp',
        version = '*',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            appearance = {
                nerd_font_variant = 'mono'
            },
            completion = {
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
