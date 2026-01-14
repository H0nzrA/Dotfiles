-- lua/config/plugins/42header.lua

-- This is NOT a lazy.nvim plugin spec, just a simple config file
-- that will be loaded by your plugins/init.lua

-- Source the vimscript file
local stdheader_path = vim.fn.stdpath("config") .. "/lua/config/plugins/stdheader.vim"

-- Check if file exists before sourcing
if vim.fn.filereadable(stdheader_path) == 1 then
  vim.cmd("source " .. stdheader_path)
  
  -- Set your 42 credentials here
  -- REPLACE these with YOUR actual 42 login and email
  -- vim.g.user42 = "h0nzra"  -- Your 42 login
  -- vim.g.mail42 = "h0nzra@student.42antananarivo.mg"  -- Your 42 email
  
  -- Additional keybindings (optional, F1 already works from the vim file)
  vim.keymap.set("n", "<leader>h", ":Stdheader<CR>", { 
    desc = "Insert 42 header",
    silent = true 
  })
  
  print("✓ 42 header loaded successfully")
else
  print("✗ Error: stdheader.vim not found at " .. stdheader_path)
end

-- Return empty table (required for lua module)
return {}
