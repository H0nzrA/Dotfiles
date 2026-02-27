-- lua/theme_switcher.lua
-- Handles loading, saving, and applying the active theme

local M = {}

-- Where the current theme choice is saved
local cache_file = vim.fn.stdpath("data") .. "/theme_choice.txt"

-- Theme definitions
local themes = {
	kanagawa = {
		plugin    = "kanagawa",
		colorscheme = "kanagawa",
		setup = function()
			require("kanagawa").setup({
				theme = "wave",
				transparent = true,
				colors = {
					theme = {
						all = {
							ui = { bg_gutter = "none" },
						},
					},
				},
				overrides = function(colors)
					local t = colors.theme
					return {
						NormalFloat  = { bg = t.ui.bg_dim },
						FloatBorder  = { fg = t.ui.shade0, bg = t.ui.bg_dim },
						LineNr       = { fg = "#3a4a5a", bg = "none" },
						LineNrAbove  = { fg = "#3a4a5a", bg = "none" },
						LineNrBelow  = { fg = "#3a4a5a", bg = "none" },
						CursorLineNr = { fg = "#7E9CD8", bg = "none", bold = true },
					}
				end,
			})
		end,
	},
	tokyonight = {
		plugin    = "tokyonight",
		colorscheme = "tokyonight",
		setup = function()
			local bg           = "#011628"
			local bg_dark      = "#011423"
			local bg_highlight = "#143652"
			local bg_search    = "#0A64AC"
			local bg_visual    = "#275378"
			local fg           = "#CBE0F0"
			local fg_dark      = "#B4D0E9"
			local fg_gutter    = "#627E97"
			local border       = "#547998"
			require("tokyonight").setup({
				style = "night",
				transparent = true,
				on_colors = function(colors)
					colors.bg           = bg
					colors.bg_dark      = colors.none
					colors.bg_float     = colors.none
					colors.bg_highlight = bg_highlight
					colors.bg_popup     = bg_dark
					colors.bg_search    = bg_search
					colors.bg_sidebar   = colors.none
					colors.bg_statusline = colors.none
					colors.bg_visual    = bg_visual
					colors.border       = border
					colors.fg           = fg
					colors.fg_dark      = fg_dark
					colors.fg_float     = fg
					colors.fg_gutter    = fg_gutter
					colors.fg_sidebar   = fg_dark
				end,
			})
		end,
	},
}

-- Returns "kanagawa" or "tokyonight" (default: kanagawa)
function M.get_saved()
	local f = io.open(cache_file, "r")
	if f then
		local name = f:read("*l")
		f:close()
		if themes[name] then return name end
	end
	return "kanagawa"
end

-- Persist the choice
local function save(name)
	local f = io.open(cache_file, "w")
	if f then f:write(name) f:close() end
end

-- Apply a theme by name
function M.apply(name)
	local t = themes[name]
	if not t then
		vim.notify("Unknown theme: " .. name, vim.log.levels.ERROR)
		return
	end
	t.setup()
	vim.cmd("colorscheme " .. t.colorscheme)
	save(name)
	vim.notify("Theme switched to: " .. name, vim.log.levels.INFO)
end

-- Toggle between the two themes
function M.toggle()
	local current = M.get_saved()
	local next_theme = (current == "kanagawa") and "tokyonight" or "kanagawa"
	M.apply(next_theme)
end

return M
