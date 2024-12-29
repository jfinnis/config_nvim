return {
    {
        -- image support inside nvim
        '3rd/image.nvim',
        opts = {},
        config = function()
            require('image').setup({
                backend = 'kitty',
                processor = 'magick_rock', -- or 'magick_cli'
                integrations = {
                    markdown = {
                        enabled = true,
                        clear_in_insert_mode = false,
                        download_remote_images = true,
                        only_render_image_at_cursor = false,
                        floating_windows = false, -- if true, images will be rendered in floating markdown windows
                        filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
                    },
                    neorg = {
                        enabled = true,
                        filetypes = { 'norg' },
                    },
                    html = {
                        enabled = false,
                    },
                    css = {
                        enabled = false,
                    },
                },
                max_width = nil,
                max_height = nil,
                max_width_window_percentage = nil,
                max_height_window_percentage = 50,
                window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
                window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
                editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
                tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
                hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif' }, -- render image files as images when opened
            })
        end
    },

    {
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
            default = {
                dir_path = 'assets',
                file_name = function()
                    local file_name = vim.fn.input("File name: ")
                    local timestamp = os.date("%Y%m%d%H%M%S")
                    return file_name .. "-" .. timestamp
                end,
            },
            filetypes = {
                norg = {
                    dir_path = '/Users/finnisj/Documents/neorg/image-src/',
                    file_name = function()
                        local file_name = vim.fn.input("File name: ")
                        local timestamp = os.date("%Y-%m-%d-%H-%M-%S")
                        return file_name .. "-" .. timestamp
                    end,
                    prompt_for_file_name = false,
                    template = ".image $FILE_PATH",
                    insert_mode_after_paste = false,
                    url_encode_path = true,
                },
                markdown = {
                    url_encode_path = true,
                    template = "![$CURSOR]($FILE_PATH)",
                    download_images = false,
                },
            },
        },
        keys = {
            { '<leader>p', '<cmd>PasteImage<cr>', desc = '[;] [P]aste image from clipboard' }
        },
    },
}
