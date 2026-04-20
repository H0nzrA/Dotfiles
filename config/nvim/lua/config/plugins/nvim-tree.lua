-- return {
-- 	"nvim-tree/nvim-tree.lua",
-- 	dependencies = "nvim-tree/nvim-web-devicons",
-- 	config= function()
-- 		local nvimtree = require("nvim-tree")
--
-- 		-- recommanded settings for nvim-tree documentation
-- 		vim.g.loaded_netrw = 1
-- 		vim.g.loader_netrwPlugin= 1
--
-- 		nvimtree.setup({
-- 			view = {
-- 				width = 50,
-- 				relativenumber = true,
-- 			},
-- 			filters = {
-- 				dotfiles = false,
-- 				custom = {},
-- 			},
-- 		})
-- 		local keymap = vim.keymap
--
-- 		keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
-- 		keymap.set("n", "<leader>o", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
-- 	end,
-- }
return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- Recommended settings for nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loader_netrwPlugin = 1

		nvimtree.setup({
			view = {
				width = 50,
				relativenumber = true,
			},
			renderer = {
				add_trailing = false,
				group_empty = false,
				highlight_git = true,
				full_name = false,
				highlight_opened_files = "none",
				root_folder_label = ":t",
				indent_markers = {
					enable = true,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "│",
						bottom = "─",
						none = " ",
					},
				},
				icons = {
					webdev_colors = true, -- Enables the colored icons like Catppuccin
					git_placement = "before",
					padding = " ",
					symlink_arrow = " ➜ ",
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
					glyphs = {
						default = "󰈚",
						symlink = "",
						bookmark = "󰆤",
						folder = {
							arrow_closed = "⏵",
							arrow_open = "⏷",
							default = "󰉋",
							open = "󰝰",
							empty = "󰜌",
							empty_open = "󰷏",
							symlink = "",
							symlink_open = "",
						},
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
					},
				},
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
