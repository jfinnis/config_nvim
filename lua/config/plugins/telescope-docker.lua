--
-- telescope-docker settings
--

require('telescope').setup {
  extensions = {
    docker = {
      -- These are the default values
      theme = 'ivy',
      binary = 'docker',
      compose_binary = 'docker compose',
      buildx_binary = 'docker buildx',
      --machine_binary = 'docker-machine',
      log_level = vim.log.levels.INFO,
      init_term = 'tabnew', -- "vsplit new", "split new", ...
      -- NOTE: init_term may also be a function that receives
      -- a command, a table of env. variables and cwd as input.
      -- This is intended only for advanced use, in case you want
      -- to send the env. and command to a tmux terminal or floaterm
      -- or something other than a built in terminal.
    },
  },
}
require('telescope').load_extension 'docker'

vim.keymap.set('n', '<leader>D', ':Telescope docker<cr>', {desc = '[;] Show [D]ocker Menu'})
vim.keymap.set('n', '<leader>dd', ':Telescope docker containers<cr>', {desc = '[;] Show [D]ocker [d] Containers'})
vim.keymap.set('n', '<leader>dc', ':Telescope docker compose<cr>', {desc = '[;] Show [D]ocker [C]ompose Files'})
vim.keymap.set('n', '<leader>di', ':Telescope docker images<cr>', {desc = '[;] Show [D]ocker [I]mages'})
vim.keymap.set('n', '<leader>df', ':Telescope docker files<cr>', {desc = '[;] Show [D]ocker [F]iles'})

-- TODO: determine if native Terminal is good enough or if should
-- investigate tmux compatibility once that's integrated


--  A table of environment variables may be passed to the pickers:
--  
--  require("telescope").extensions.docker.containers({
--    env = {
--    -- ...
--    }
--  })
--  -- NOTE: docker env variables may also be added as a global vim variable,
--  -- but will be overriden by the env passed to the function itself
--  vim.g.docker_env = {
--    -- ...
--  }


-- TODO: experiment with remote host
--  To connect to a remote docker host, an accessible host may be provided to the command:
--  
--  Telescope docker containers host=ssh://....
--  or a DOCKER_HOST environment variable may be set:
--  
--  require("telescope").extensions.docker.containers({
--    env = {
--      DOCKER_HOST = "ssh://...."
--    }
--  })
--  -- OR
--  vim.g.docker_env = {
--    DOCKER_HOST = "..."
--  }
--  In the example above, the containers would be then fetched from the provided docker host. The same works for all other pickers, except for dockerfiles and docker compose files.
