return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		-- Your original color scheme with Catppuccin Mocha touches
		local colors = {
			blue = "#89B4FA",      -- Catppuccin blue
			green = "#A6E3A1",     -- Catppuccin green
			violet = "#CBA6F7",    -- Catppuccin mauve
			yellow = "#F9E2AF",    -- Catppuccin yellow
			red = "#F38BA8",       -- Catppuccin red
			fg = "#CDD6F4",        -- Catppuccin text
			bg = "#1E1E2E",        -- Catppuccin base (slightly visible for contrast)
			inactive_bg = "#181825", -- Catppuccin mantle
		}

		-- Your original theme structure with Catppuccin colors
		local perso_lualine_theme = {
			normal = {
				a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.inactive_bg, fg = colors.fg, gui = "bold" },
				b = { bg = colors.inactive_bg, fg = colors.fg },
				c = { bg = colors.inactive_bg, fg = colors.fg },
			},
		}

		local hide_in_width = function()
			return vim.fn.winwidth(0) > 100
		end

		local diagnostics = {
			'diagnostics',
			sources = { 'nvim_diagnostic' },
			sections = { 'error', 'warn' },
			symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
			colored = false,
			update_in_insert = false,
			always_visible = false,
			cond = hide_in_width,
		}

		-- Configure lualine - keeping your original simple structure
		lualine.setup({
			options = {
				theme = perso_lualine_theme,
				icons_enabled = true,
				--          
				section_separators = { left = '' , right = ""},
				always_divide_middle = true,
			},
			sections = {
				lualine_x = {
					diagnostics,
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
