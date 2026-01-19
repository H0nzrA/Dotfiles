-- plugins/float-terminal.lua
return {
  "akinsho/toggleterm.nvim", -- dummy plugin dependency, can be empty string ""
  config = function()
    -- Escape terminal mode with double escape
    vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Define window configuration
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local open_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
    -- Enter insert mode automatically when opening terminal
    vim.cmd.startinsert()
  end
end

local close_terminal = function()
  if vim.api.nvim_win_is_valid(state.floating.win) then
    vim.api.nvim_win_hide(state.floating.win)
  end
end

-- Create user command
vim.api.nvim_create_user_command("Floaterminal", open_terminal, {})

-- <leader>` to OPEN terminal
vim.keymap.set({ "n", "t" }, "<leader>`", open_terminal, {
  desc = "Open floating terminal",
  noremap = true,
  silent = true,
})

-- <leader>' to CLOSE terminal
vim.keymap.set({ "n", "t" }, "<leader>'", close_terminal, {
  desc = "Close floating terminal",
  noremap = true,
  silent = true,
})

-- Optional: Close terminal with q in normal mode
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.keymap.set("n", "q", close_terminal, { buffer = true, desc = "Close terminal" })
  end,
})
  end,
}
