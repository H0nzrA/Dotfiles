-- Space as may key for neovim
vim.g.mapleader = " "

local keymap = vim.keymap 

-- Search Keymaps
keymap.set("n", "<leader>nh", ":noh<CR>", { desc = "clear search highlights" })

-- Window managments
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window verically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split"})

-- Tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open currnet buffer in new tab" })


-- Markdown specific keymaps (only active in markdown files)
local markdown_augroup = vim.api.nvim_create_augroup("MarkdownKeymaps", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = markdown_augroup,
	pattern = "markdown",
	callback = function()
		local opts = { buffer = true, silent = true }

		-- Headers
		keymap.set("n", "<leader>m1", "I# <Esc>", vim.tbl_extend("force", opts, { desc = "H1 header" }))
		keymap.set("n", "<leader>m2", "I## <Esc>", vim.tbl_extend("force", opts, { desc = "H2 header" }))
		keymap.set("n", "<leader>m3", "I### <Esc>", vim.tbl_extend("force", opts, { desc = "H3 header" }))
		keymap.set("n", "<leader>m4", "I#### <Esc>", vim.tbl_extend("force", opts, { desc = "H4 header" }))

		-- Formatting (Visual mode)
		keymap.set("v", "<leader>mb", "c**<C-r>\"**<Esc>", vim.tbl_extend("force", opts, { desc = "Bold" }))
		keymap.set("v", "<leader>mi", "c*<C-r>\"*<Esc>", vim.tbl_extend("force", opts, { desc = "Italic" }))
		keymap.set("v", "<leader>mc", "c`<C-r>\"`<Esc>", vim.tbl_extend("force", opts, { desc = "Code inline" }))
		keymap.set("v", "<leader>ms", "c~~<C-r>\"~~<Esc>", vim.tbl_extend("force", opts, { desc = "Strikethrough" }))

		-- Lists
		keymap.set("n", "<leader>ml", "I- <Esc>", vim.tbl_extend("force", opts, { desc = "Bullet list" }))
		keymap.set("n", "<leader>mn", "I1. <Esc>", vim.tbl_extend("force", opts, { desc = "Numbered list" }))
		keymap.set("n", "<leader>mx", "I- [ ] <Esc>", vim.tbl_extend("force", opts, { desc = "Checkbox" }))

		-- Links and images
		keymap.set("v", "<leader>mk", "c[<C-r>\"]()<Esc>i", vim.tbl_extend("force", opts, { desc = "Create link" }))
		keymap.set("n", "<leader>mf", "i![]()<Esc>hi", vim.tbl_extend("force", opts, { desc = "Insert image" }))

		-- Code blocks
		keymap.set("n", "<leader>mC", "o```<CR>```<Esc>kA", vim.tbl_extend("force", opts, { desc = "Code block" }))

		-- Toggle checkbox
		vim.keymap.set("n", "<leader>mt", function()
			local line = vim.api.nvim_get_current_line()
			if line:match("%- %[ %]") then
				vim.api.nvim_set_current_line(line:gsub("%- %[ %]", "- [x]"))
			elseif line:match("%- %[x%]") then
				vim.api.nvim_set_current_line(line:gsub("%- %[x%]", "- [ ]"))
			end
		end, vim.tbl_extend("force", opts, { desc = "Toggle checkbox" }))
	end,
})

