return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
		  defaults = {
			path_display = { "smart" },
			preview = {
			  treesitter = false,
			},
			mappings = {
			  i = {
				["<C-k>"] = actions.move_selection_previous, -- move to prev result
				["<C-j>"] = actions.move_selection_next, -- move to next result
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			  },
			},
			file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/" },
		  },
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
		keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find todos" })
	end
}

-- return {
-- 	"nvim-telescope/telescope.nvim",
-- 	branch = "0.1.x",
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim",
-- 		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
-- 		"nvim-tree/nvim-web-devicons",
-- 		"folke/todo-comments.nvim",
-- 	},
-- 	config = function()
-- 		local telescope = require("telescope")
-- 		local actions = require("telescope.actions")

-- 		telescope.setup({
-- 			defaults = {
-- 				path_display = { "smart" },
-- 				preview = {
-- 					treesitter = false,
-- 				},
-- 				layout_config = {
-- 					horizontal = {
-- 						prompt_position = "top",
-- 						preview_width = 0.55,
-- 						results_width = 0.8,
-- 					},
-- 					vertical = {
-- 						mirror = false,
-- 					},
-- 					width = 0.87,
-- 					height = 0.80,
-- 					preview_cutoff = 120,
-- 				},
-- 				prompt_prefix = "   ",
-- 				selection_caret = "  ",
-- 				entry_prefix = "  ",
-- 				initial_mode = "insert",
-- 				selection_strategy = "reset",
-- 				sorting_strategy = "ascending",
-- 				layout_strategy = "horizontal",
-- 				file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/" },
-- 				winblend = 0,
-- 				border = true,
-- 				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
-- 				color_devicons = true,
-- 				set_env = { ["COLORTERM"] = "truecolor" },
-- 				mappings = {
-- 					i = {
-- 						["<C-k>"] = actions.move_selection_previous,
-- 						["<C-j>"] = actions.move_selection_next,
-- 						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
-- 						["<C-x>"] = actions.delete_buffer,
-- 						["<C-u>"] = actions.preview_scrolling_up,
-- 						["<C-d>"] = actions.preview_scrolling_down,
-- 					},
-- 					n = {
-- 						["q"] = actions.close,
-- 					},
-- 				},
-- 			},
-- 			pickers = {
-- 				find_files = {
-- 					theme = "dropdown",
-- 					previewer = false,
-- 					find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
-- 				},
-- 				git_files = {
-- 					theme = "dropdown",
-- 					previewer = false,
-- 				},
-- 				buffers = {
-- 					theme = "dropdown",
-- 					previewer = false,
-- 					initial_mode = "normal",
-- 				},
-- 				live_grep = {
-- 					theme = "ivy",
-- 				},
-- 				grep_string = {
-- 					theme = "ivy",
-- 				},
-- 			},
-- 		})

-- 		telescope.load_extension("fzf")

-- 		-- Enhanced keymaps
-- 		local keymap = vim.keymap

-- 		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
-- 		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
-- 		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
-- 		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
-- 		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
-- 		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
-- 		keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keymaps" })
-- 		keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help" })
-- 	end,
-- }