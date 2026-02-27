-- plugins/colorscheme.lua
-- Loads both theme plugins; the active one is chosen by theme_switcher

return {
	-- Kanagawa
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
	},
	-- Tokyonight
	{
		"folke/tokyonight.nvim",
		lazy = true,
	},
	-- Loader: picks up saved theme on startup and registers the toggle command
	{
		"nvim-lua/plenary.nvim", -- already a dependency you have, just piggybacks
		priority = 1000,
		config = function()
			local switcher = require("theme_switcher")

			-- Apply whichever theme was last saved (or default: kanagawa)
			switcher.apply(switcher.get_saved())

			-- :ThemeToggle  → swap between the two
			vim.api.nvim_create_user_command("ThemeToggle", function()
				switcher.toggle()
			end, { desc = "Toggle between Kanagawa and Tokyonight" })

			-- Optional keybind: <leader>tt
			vim.keymap.set("n", "<leader>tt", "<cmd>ThemeToggle<CR>", {
				noremap = true,
				silent = true,
				desc = "Toggle theme",
			})
		end,
	},
}
