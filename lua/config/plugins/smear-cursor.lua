--
-- smear-cursor - animate some cursor movements/jumps
--

return {
    'sphamba/smear-cursor.nvim',
    opts = {
        smear_between_neighbor_lines = false,
        smear_to_cmd = false,
        legacy_computing_symbols_support = true,
        -- cursor_color = '#ff8800',

        -- make it a bit snappier
        stiffness = 0.8, -- default 0.6
        trailing_stiffness = 0.5, -- default 0.3
        distance_stop_animating = 0.5, -- default 0.1
        hide_target_hack = false, -- default true
    },
}
