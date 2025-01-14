--
-- tiny-glimmer - animate yanked text highlight
--

return {
    'rachartier/tiny-glimmer.nvim',
    event = 'TextYankPost',
    opts = {
        default_animation = 'left_to_right',
        transparency_color = '#31353a',
        animations = {
            left_to_right = {
                max_duration = 200,
                lingering_time = 100,
            }
        }
    },
}
