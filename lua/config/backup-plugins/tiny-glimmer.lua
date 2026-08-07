--
-- tiny-glimmer - animate yanked text highlight
--

return {
    'rachartier/tiny-glimmer.nvim',
    event = 'VeryLazy',
    opts = {
        default_animation = 'left_to_right',
        transparency_color = '#4D91FF',
        animations = {
            -- TODO: doesn't seem to be working right now, check again soon to see if fixed
            left_to_right = {
                max_duration = 200,
                min_duration = 150,
                min_progress = 0.85,
                lingering_time = 100,
                chars_for_max_duration = 25,
            }
        },
        overwrite = {
            -- call tiny glimmer when pasting or searching
            auto_map = true,
            paste = {
                enabled = true,
                default_animation = 'left_to_right',
                next_mapping = 'nzzzv',
                prev_mapping = 'pzzzv',
            },
            search = {
                enabled = true,
                default_animation = 'left_to_right',
                paste_mapping = 'p',
                Paste_mapping = 'P',
            },
            undo = {
                enabled = true,
                default_animation = 'left_to_right',
                undo_mapping = 'u',
            },
            redo = {
                enabled = true,
                default_animation = 'left_to_right',
                redo_mapping = '<c-r>',
            },
        }
    },
}
