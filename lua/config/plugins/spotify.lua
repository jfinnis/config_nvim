--
-- spotify - notifications and commands
--

-- TODO: command: add to playlist 
-- command: like song
-- view discography?

local is_focused = false
local last_song_info = nil

-- Keep track of the instance of nvim that is focused so we don't have background instances
-- calling scripts unnecessarily.
vim.api.nvim_create_autocmd({'FocusGained', 'FocusLost'}, {
    callback = function(event)
        if event.event == 'FocusGained' then
            is_focused = true
        else
            is_focused = false
        end
    end
})

local function notify_song_info()
    if is_focused then
        local file = vim.fn.stdpath 'config' .. '/scripts/now-playing.sh'
        local song_info = vim.trim(vim.fn.system('bash ' .. vim.fn.shellescape(file)))

        if song_info ~= last_song_info then
            -- require('noice').notify(message, level, { title = 'Spotify' })
            vim.notify(song_info, vim.log.levels.INFO, { title = 'Spotify' })
            last_song_info = song_info
        end
    end
end

-- Polling setup to check for song info changes every 3 seconds
local function start_polling()
    local timer = vim.loop.new_timer()
    timer:start(0, 3000, vim.schedule_wrap(notify_song_info))
end

start_polling()
