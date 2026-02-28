return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 800
	end,
	config = function()
		local wk = require("which-key")

		wk.setup({
			preset = "modern",
			delay = 600,
			plugins = {
				marks = true,
				registers = true,
				spelling = {
					enabled = true,
					suggestions = 20,
				},
				presets = {
					operators = true,
					motions = true,
					text_objects = true,
					windows = true,
					nav = true,
					z = true,
					g = true,
				},
			},
			win = {
				border = "rounded",
				padding = { 1, 2 },
				title = true,
				title_pos = "center",
				zindex = 1000,
			},
			layout = {
				height = { min = 4, max = 25 },
				width = { min = 20, max = 50 },
				spacing = 3,
				align = "left",
			},
			show_help = true,
			show_keys = true,
			triggers = {
				{ "<auto>", mode = "nxsot" },
			},
		})

		-- Register group names and icons
		wk.add({
			{ "<leader>f", group = " Find" },
			{ "<leader>w", group = " Session" },
			{ "<leader>s", group = " Split/Search" },
			{ "<leader>t", group = " Tab" },
			{ "<leader>x", group = " Trouble" },
			{ "<leader>h", group = " Git Hunk" },
			{ "<leader>l", group = " LSP" },
			{ "<leader>n", group = " Misc" },
			{ "<leader>c", group = " Code" },
			{ "[", group = " Previous" },
			{ "]", group = " Next" },
			{ "g", group = " Goto" },
		})
	end,
}
