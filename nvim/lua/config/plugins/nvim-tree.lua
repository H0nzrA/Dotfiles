return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config= function()
		local nvimtree = require("nvim-tree")

		-- recommanded settings for nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loader_netrwPlugin= 1

		nvimtree.setup({
			view = {
				width = 50,
				relativenumber = true,
			},
			filters = {
				dotfiles = false,
				custom = {},
			},
		})
		local keymap = vim.keymap

		keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
		keymap.set("n", "<leader>o", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
	end,
}
