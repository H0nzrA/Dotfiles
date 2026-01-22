-- Source the vimscript file
local stdheader_path = vim.fn.stdpath("config") .. "/lua/config/plugins/stdheader.vim"

-- Check if file exists before sourcing
if vim.fn.filereadable(stdheader_path) == 1 then
  vim.cmd("source " .. stdheader_path)
  
  vim.g.user42 = "trakotoz"  -- 42 login
  vim.g.mail42 = "trakotoz@student.42antananarivo.mg"  -- 42 email
  
  -- Additional keybindings (optional, F1 already works from the vim file)
  vim.keymap.set("n", "<leader>h", ":Stdheader<CR>", { 
    desc = "Insert 42 header",
    silent = true 
  })
  
  -- Non-blocking notification using nvim-notify
  vim.defer_fn(function()
    vim.notify("✓ 42 header loaded successfully", vim.log.levels.INFO, {
      title = "42 Header",
      timeout = 2000,
    })
  end, 100)
else
  -- Error notification
  vim.defer_fn(function()
    vim.notify("✗ Error: stdheader.vim not found at " .. stdheader_path, vim.log.levels.ERROR, {
      title = "42 Header",
      timeout = 5000,
    })
  end, 100)
end

-- Return empty table (required for lua module)
return {}
