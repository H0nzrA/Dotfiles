-- lua/config/plugins/flake8.lua
-- Flake8 (Python linting) + autopep8 (Python formatting)
-- Mirrors the norminette.lua structure for 42 students coding in Python
--
-- Keybindings (Python files only):
--   Ctrl+S      → Format with autopep8
--   <leader>n   → Check current file with flake8
--   <leader>N   → Check entire directory with flake8
--
-- Commands:
--   :FormatPy        → autopep8 format
--   :Flake8          → flake8 on current file
--   :Flake8Dir       → flake8 on current directory
--
-- Requirements:
--   pip install autopep8 flake8

local M = {}

-- Helper: is the current file a Python file?
local function is_python()
  return vim.bo.filetype == 'python'
end

-- ─────────────────────────────────────────────
-- FORMAT with autopep8 (Ctrl+S)
-- ─────────────────────────────────────────────
M.format_file = function()
  if not is_python() then
    -- Fall through: let other plugins / mappings handle non-Python files
    -- (so Ctrl+S still works normally for C files via norminette.lua)
    vim.cmd('write')
    return
  end

  local file = vim.fn.expand('%:p')

  if vim.fn.filereadable(file) == 0 then
    vim.notify("No file to format", vim.log.levels.WARN)
    return
  end

  -- Check autopep8 is available
  if vim.fn.executable('autopep8') == 0 then
    vim.notify("✗ autopep8 not found. Run: pip install autopep8", vim.log.levels.ERROR)
    return
  end

  -- Save before formatting
  vim.cmd('write')

  -- Run autopep8 in-place with aggressive mode (fixes more issues)
  local cmd = 'autopep8 --in-place --aggressive --aggressive ' .. vim.fn.shellescape(file)
  local output = vim.fn.system(cmd)
  local exit_code = vim.v.shell_error

  -- Reload buffer to reflect changes
  vim.cmd('edit!')

  if exit_code == 0 then
    vim.notify("✓ File formatted with autopep8", vim.log.levels.INFO)
  else
    vim.notify("✗ autopep8 failed: " .. output, vim.log.levels.ERROR)
  end
end

-- ─────────────────────────────────────────────
-- CHECK current file with flake8 (<leader>n)
-- ─────────────────────────────────────────────
M.run_flake8 = function()
  local file = vim.fn.expand('%:p')

  if vim.fn.filereadable(file) == 0 then
    vim.notify("No file to check", vim.log.levels.WARN)
    return
  end

  if vim.fn.executable('flake8') == 0 then
    vim.notify("✗ flake8 not found. Run: pip install flake8", vim.log.levels.ERROR)
    return
  end

  vim.cmd('write')

  local output = vim.fn.system('flake8 ' .. vim.fn.shellescape(file))
  local exit_code = vim.v.shell_error

  -- If no output and exit 0 → clean
  if exit_code == 0 and output == '' then
    output = vim.fn.expand('%:t') .. ' — no issues found ✓'
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf, 'swapfile', false)

  local lines = vim.split(output, '\n')
  -- Remove trailing empty line if present
  if lines[#lines] == '' then table.remove(lines) end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  vim.cmd('botright split')
  vim.api.nvim_win_set_buf(0, buf)
  vim.api.nvim_win_set_height(0, math.min(15, #lines + 1))

  vim.api.nvim_buf_set_name(buf, 'Flake8 Output')
  vim.api.nvim_buf_set_option(buf, 'filetype', 'flake8')

  -- Syntax highlighting
  vim.cmd([[
    syntax match Flake8Error /E[0-9]\+/
    syntax match Flake8Warning /W[0-9]\+/
    syntax match Flake8OK /no issues found/
    highlight link Flake8Error Error
    highlight link Flake8Warning WarningMsg
    highlight link Flake8OK String
  ]])

  -- Close with q
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':q<CR>', {
    noremap = true,
    silent = true
  })

  if exit_code == 0 then
    vim.notify("✓ Flake8: No issues!", vim.log.levels.INFO)
  else
    vim.notify("✗ Flake8: Issues found", vim.log.levels.ERROR)
  end
end

-- ─────────────────────────────────────────────
-- CHECK entire directory with flake8 (<leader>N)
-- ─────────────────────────────────────────────
M.run_flake8_dir = function()
  local cwd = vim.fn.getcwd()

  if vim.fn.executable('flake8') == 0 then
    vim.notify("✗ flake8 not found. Run: pip install flake8", vim.log.levels.ERROR)
    return
  end

  vim.cmd('write')

  local output = vim.fn.system('flake8 ' .. vim.fn.shellescape(cwd))
  local exit_code = vim.v.shell_error

  if exit_code == 0 and output == '' then
    output = 'Directory ' .. cwd .. ' — no issues found ✓'
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(buf, 'swapfile', false)

  local lines = vim.split(output, '\n')
  if lines[#lines] == '' then table.remove(lines) end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  vim.cmd('botright split')
  vim.api.nvim_win_set_buf(0, buf)
  vim.api.nvim_win_set_height(0, math.min(20, #lines + 1))

  vim.api.nvim_buf_set_name(buf, 'Flake8 Directory Output')
  vim.api.nvim_buf_set_option(buf, 'filetype', 'flake8')

  vim.cmd([[
    syntax match Flake8Error /E[0-9]\+/
    syntax match Flake8Warning /W[0-9]\+/
    syntax match Flake8OK /no issues found/
    highlight link Flake8Error Error
    highlight link Flake8Warning WarningMsg
    highlight link Flake8OK String
  ]])

  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':q<CR>', {
    noremap = true,
    silent = true
  })

  if exit_code == 0 then
    vim.notify("✓ Flake8: All files OK!", vim.log.levels.INFO)
  else
    vim.notify("✗ Flake8: Issues found in directory", vim.log.levels.ERROR)
  end
end

-- ─────────────────────────────────────────────
-- KEY BINDINGS (Python files only for n/N,
-- Ctrl+S overrides globally but falls back for non-Python)
-- ─────────────────────────────────────────────

-- Ctrl+S → autopep8 format (Python only, falls back to :write for others)
-- vim.keymap.set('n', '<C-s>', M.format_file, {
--   desc = 'Format Python file with autopep8 (or save for other filetypes)',
--   silent = true
-- })

-- <leader>n → flake8 current file (Python only)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.keymap.set('n', '<leader>n', M.run_flake8, {
      buffer = true,
      desc = 'Run Flake8 on current file',
      silent = true
    })
    vim.keymap.set('n', '<leader>N', M.run_flake8_dir, {
      buffer = true,
      desc = 'Run Flake8 on directory',
      silent = true
    })
  end,
})

-- ─────────────────────────────────────────────
-- USER COMMANDS
-- ─────────────────────────────────────────────
vim.api.nvim_create_user_command('FormatPy', M.format_file, {})
vim.api.nvim_create_user_command('Flake8', M.run_flake8, {})
vim.api.nvim_create_user_command('Flake8Dir', M.run_flake8_dir, {})


_G._42tools = _G._42tools or {}
_G._42tools.flake8 = M
return {}
