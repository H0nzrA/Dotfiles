-- lua/config/plugins/norminette.lua

-- This is NOT a lazy.nvim plugin spec, just a simple config file
-- that will be loaded by your plugins/init.lua

local M = {}

-- Function to run norminette on current file
M.run_norminette = function()
  local file = vim.fn.expand('%:p')
  
  -- Check if file exists
  if vim.fn.filereadable(file) == 0 then
    vim.notify("No file to check", vim.log.levels.WARN)
    return
  end
  
  -- Save file before running norminette
  vim.cmd('write')
  
  -- Run norminette and capture output
  local output = vim.fn.system('norminette ' .. vim.fn.shellescape(file))
  local exit_code = vim.v.shell_error
  
  -- Create a new buffer for output
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf, 'swapfile', false)
  
  -- Split output into lines
  local lines = vim.split(output, '\n')
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  
  -- Open in a split window
  vim.cmd('botright split')
  vim.api.nvim_win_set_buf(0, buf)
  vim.api.nvim_win_set_height(0, math.min(15, #lines))
  
  -- Set buffer name and syntax
  vim.api.nvim_buf_set_name(buf, 'Norminette Output')
  vim.api.nvim_buf_set_option(buf, 'filetype', 'norminette')
  
  -- Add syntax highlighting for errors
  vim.cmd([[
    syntax match NorminetteError /Error/
    syntax match NorminetteOK /OK!/
    highlight link NorminetteError Error
    highlight link NorminetteOK String
  ]])
  
  -- Make buffer closable with q
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':q<CR>', { 
    noremap = true, 
    silent = true 
  })
  
  -- Notify result
  if exit_code == 0 then
    vim.notify("✓ Norminette: OK!", vim.log.levels.INFO)
  else
    vim.notify("✗ Norminette: Errors found", vim.log.levels.ERROR)
  end
end

-- Function to run norminette on entire directory
M.run_norminette_dir = function()
  local cwd = vim.fn.getcwd()
  vim.cmd('write')
  
  local output = vim.fn.system('norminette ' .. vim.fn.shellescape(cwd))
  local exit_code = vim.v.shell_error
  
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  
  local lines = vim.split(output, '\n')
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  
  vim.cmd('botright split')
  vim.api.nvim_win_set_buf(0, buf)
  vim.api.nvim_win_set_height(0, math.min(20, #lines))
  
  vim.api.nvim_buf_set_name(buf, 'Norminette Directory Output')
  vim.api.nvim_buf_set_option(buf, 'filetype', 'norminette')
  
  vim.cmd([[
    syntax match NorminetteError /Error/
    syntax match NorminetteOK /OK!/
    highlight link NorminetteError Error
    highlight link NorminetteOK String
  ]])
  
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':q<CR>', { 
    noremap = true, 
    silent = true 
  })
  
  if exit_code == 0 then
    vim.notify("✓ Norminette: All files OK!", vim.log.levels.INFO)
  else
    vim.notify("✗ Norminette: Errors found in directory", vim.log.levels.ERROR)
  end
end

-- Ctrl+S to run norminette on current file
vim.keymap.set('n', '<C-s>', M.run_norminette, { 
  desc = 'Run Norminette on current file',
  silent = true 
})

-- Leader+N for norminette on directory
vim.keymap.set('n', '<leader>N', M.run_norminette_dir, { 
  desc = 'Run Norminette on directory',
  silent = true 
})

-- Create commands
vim.api.nvim_create_user_command('Norminette', M.run_norminette, {})
vim.api.nvim_create_user_command('NorminetteDir', M.run_norminette_dir, {})

-- Notify on load (non-blocking)
vim.defer_fn(function()
  vim.notify("✓ Norminette keybindings loaded (Ctrl+S)", vim.log.levels.INFO, {
    title = "Norminette",
    timeout = 2000,
  })
end, 100)

-- Return empty table (required for lazy.nvim compatibility)
return {}
