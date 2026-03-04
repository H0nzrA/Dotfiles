-- ── File 2: mini-indentscope.lua ──────────────────────────────────────────
-- Animated active scope line — draws a bright line around your current block
return {
	"echasnovski/mini.indentscope",
	version = false,
	event = { "BufReadPre", "BufNewFile" },
	init = function()
		-- Disable for special buffers
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"help", "alpha", "dashboard", "neo-tree",
				"Trouble", "trouble", "lazy", "mason",
				"notify", "toggleterm", "lazyterm",
			},
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
	end,
	config = function()
		-- Bright active scope color — stands out against the dimmed ibl guides
		vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol",       { fg = "#89B4FA", nocombine = true }) -- Catppuccin blue
		vim.api.nvim_set_hl(0, "MiniIndentscopeSymbolOff",    { fg = "#313244", nocombine = true }) -- surface1 (fades out)

		require("mini.indentscope").setup({
			-- The character drawn for the active scope line
			symbol = "│", -- ┊ or │

			options = {
				-- Which border of the scope to use as reference
				border = "both",     -- "top" | "bottom" | "both" | "none"
				-- How deep to detect scope (nil = auto)
				indent_at_cursor = true,
				-- Try to detect scope from both top and bottom
				try_as_border = true,
			},

			-- Animation: this is the "light up" effect
			draw = {
				-- Delay before animation starts (ms) — lower = snappier
				delay = 50,

				-- Animation style — choose ONE:
				animation = require("mini.indentscope").gen_animation.quadratic({
					easing = "in-out",       -- "in" | "out" | "in-out"
					duration = 60,       -- total animation duration in ms
					unit = "total",        -- "step" | "total"
				}),

				-- Alternative animations (swap any in above):
				-- require("mini.indentscope").gen_animation.none()        -- instant, no animation
				-- require("mini.indentscope").gen_animation.linear(...)   -- constant speed
				-- require("mini.indentscope").gen_animation.exponential(...) -- fast then slow
				-- require("mini.indentscope").gen_animation.quadratic(...) -- fast then slow
			},
		})
	end,
}
