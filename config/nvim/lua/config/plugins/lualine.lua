return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		-- Catppuccin Mocha palette
		local colors = {
			blue      = "#89B4FA",
			green     = "#A6E3A1",
			violet    = "#CBA6F7",
			yellow    = "#F9E2AF",
			red       = "#F38BA8",
			peach     = "#FAB387",
			teal      = "#94E2D5",
			sky       = "#89DCEB",
			fg        = "#CDD6F4",
			subtext   = "#A6ADC8",
			overlay   = "#6C7086",
			surface1  = "#313244",
			surface0  = "#1E1E2E",
			bg        = "#1E1E2E",
			mantle    = "#181825",
			crust     = "#11111B",
		}

		local theme = {
			normal = {
				a = { bg = colors.blue,   fg = colors.crust, gui = "bold" },
				b = { bg = colors.surface1, fg = colors.fg },
				c = { bg = colors.mantle,  fg = colors.subtext },
			},
			insert = {
				a = { bg = colors.green,  fg = colors.crust, gui = "bold" },
				b = { bg = colors.surface1, fg = colors.fg },
				c = { bg = colors.mantle,  fg = colors.subtext },
			},
			visual = {
				a = { bg = colors.violet, fg = colors.crust, gui = "bold" },
				b = { bg = colors.surface1, fg = colors.fg },
				c = { bg = colors.mantle,  fg = colors.subtext },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.crust, gui = "bold" },
				b = { bg = colors.surface1, fg = colors.fg },
				c = { bg = colors.mantle,  fg = colors.subtext },
			},
			replace = {
				a = { bg = colors.red,    fg = colors.crust, gui = "bold" },
				b = { bg = colors.surface1, fg = colors.fg },
				c = { bg = colors.mantle,  fg = colors.subtext },
			},
			inactive = {
				a = { bg = colors.mantle, fg = colors.overlay, gui = "bold" },
				b = { bg = colors.mantle, fg = colors.overlay },
				c = { bg = colors.mantle, fg = colors.overlay },
			},
		}

		-- ── Helpers ────────────────────────────────────────────────────────────
		local function wide() return vim.fn.winwidth(0) > 100 end
		local function medium() return vim.fn.winwidth(0) > 70 end

		-- ── Mode icon map ──────────────────────────────────────────────────────
		local mode_icons = {
			n  = "󰋜 NOR", i  = "󰏫 INS", v  = "󰩭 VIS",
			V  = "󰩭 V·L", ["\22"] = "󰩭 V·B",
			c  = "󰞷 CMD", R  = "󰑎 REP", s  = "󰒅 SEL",
			S  = "󰒅 S·L", t  = "󰆍 TER",
		}
		local function mode_label()
			local m = vim.fn.mode()
			return mode_icons[m] or ("󰋜 " .. m:upper())
		end

		-- ── Git branch with icon ───────────────────────────────────────────────
		local branch = {
			"branch",
			icon = "",
			color = { fg = colors.violet, gui = "bold" },
			cond = medium,
		}

		-- ── Git diff ──────────────────────────────────────────────────────────
		local diff = {
			"diff",
			symbols = { added = " ", modified = " ", removed = " " },
			diff_color = {
				added    = { fg = colors.green },
				modified = { fg = colors.yellow },
				removed  = { fg = colors.red },
			},
			cond = wide,
		}

		-- ── Diagnostics ───────────────────────────────────────────────────────
		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn", "info", "hint" },
			symbols = { error = " ", warn = " ", info = " ", hint = "󰌶 " },
			diagnostics_color = {
				error = { fg = colors.red },
				warn  = { fg = colors.yellow },
				info  = { fg = colors.sky },
				hint  = { fg = colors.teal },
			},
			colored = true,
			update_in_insert = false,
			always_visible = false,
			cond = wide,
		}

		-- ── LSP server name ───────────────────────────────────────────────────
		local lsp_name = {
			function()
				local clients = vim.lsp.get_active_clients({ bufnr = 0 })
				if #clients == 0 then return "󰅚 no lsp" end
				local names = {}
				for _, c in ipairs(clients) do
					if c.name ~= "null-ls" and c.name ~= "copilot" then
						table.insert(names, c.name)
					end
				end
				return #names > 0 and ("󰒍 " .. table.concat(names, ", ")) or "󰅚 no lsp"
			end,
			color = { fg = colors.teal },
			cond = wide,
		}

		-- ── Lazy updates ──────────────────────────────────────────────────────
		local lazy_updates = {
			lazy_status.updates,
			cond = function() return wide() and lazy_status.has_updates() end,
			color = { fg = colors.peach },
		}

		-- ── File info ─────────────────────────────────────────────────────────
		local filetype = {
			"filetype",
			colored = true,
			icon_only = false,
			color = { fg = colors.fg },
		}

		local fileformat = {
			"fileformat",
			symbols = { unix = " lf", dos = " crlf", mac = " cr" },
			color = { fg = colors.overlay },
			cond = wide,
		}

		local encoding = {
			"encoding",
			color = { fg = colors.overlay },
			cond = wide,
		}

		-- ── Progress / location ───────────────────────────────────────────────
		local progress = {
			"progress",
			color = { fg = colors.subtext },
		}

		local location = {
			function()
				local line = vim.fn.line(".")
				local col  = vim.fn.virtcol(".")
				local tot  = vim.fn.line("$")
				return string.format("󰍒 %d:%d  %d", line, col, tot)
			end,
			color = { fg = colors.subtext },
		}

		-- ── Setup ─────────────────────────────────────────────────────────────
		lualine.setup({
			options = {
				theme = theme,
				icons_enabled = true,
				section_separators = { left = '', right = '' },
				component_separators = { left = '', right = '' },
				always_divide_middle = true,
				globalstatus = true,
			},

			sections = {
				lualine_a = {
					{
						'mode',
						fmt = function(str)
							return "󰄛 " .. str
						end,
					},
				},

				lualine_b = {
					{
						'branch',
						icon = '',
					},
				},

				lualine_c = {
					{
						'filename',
						path = 1,
						symbols = {
							modified = ' ●',
							readonly = ' ',
							unnamed = '[No Name]',
						},
					},
				},

				lualine_x = {
					diagnostics,
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						icon = "󰒲 ",
						color = { fg = "#ff9e64" },
					},
					{ "encoding", icon = "󰈙 " },
					{ "fileformat", icon = "󰌽 " },
					{ "filetype", icon_only = false },
				},

				lualine_y = {
					{ "progress", icon = "󰊕 " },
				},

				lualine_z = {
					{
						"location",
						icon = "󰍒 ",
					},
				},
			},
		})
	end,
}
