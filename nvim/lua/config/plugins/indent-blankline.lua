return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
	config = function()
		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}

		local hooks = require("ibl.hooks")
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#F38BA8" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#F9E2AF" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#89B4FA" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#FAB387" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#A6E3A1" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#CBA6F7" })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#94E2D5" })
		end)

		require("ibl").setup({
			indent = {
				char = "┊",
				highlight = highlight,
			},
			scope = {
				enabled = true,
				show_start = true,
				show_end = true,
				highlight = highlight,
			},
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		})
	end,
}
