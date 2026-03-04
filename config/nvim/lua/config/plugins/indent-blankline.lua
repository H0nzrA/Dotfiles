-- ── File 1: indent-blankline.lua ──────────────────────────────────────────
-- Static rainbow indent guides (your original, lightly tuned)
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

		-- Catppuccin Mocha colors — dimmed slightly so active scope pops
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowRed",    { fg = "#6b3d47" }) -- dimmed
			vim.api.nvim_set_hl(0, "RainbowYellow",  { fg = "#6b5e3f" })
			vim.api.nvim_set_hl(0, "RainbowBlue",    { fg = "#3d5273" })
			vim.api.nvim_set_hl(0, "RainbowOrange",  { fg = "#6b4d33" })
			vim.api.nvim_set_hl(0, "RainbowGreen",   { fg = "#3d5c3f" })
			vim.api.nvim_set_hl(0, "RainbowViolet",  { fg = "#55446b" })
			vim.api.nvim_set_hl(0, "RainbowCyan",    { fg = "#2e5c5c" })
		end)

		require("ibl").setup({
			indent = {
				char = "│",           -- solid line, mini.indentscope will animate over it
				highlight = highlight,
				smart_indent_cap = true,
			},
			scope = {
				enabled = false,      -- DISABLE ibl scope — mini.indentscope handles this
			},
			exclude = {
				filetypes = {
					"help", "alpha", "dashboard", "neo-tree",
					"Trouble", "trouble", "lazy", "mason",
					"notify", "toggleterm", "lazyterm",
				},
			},
		})
	end,
}
