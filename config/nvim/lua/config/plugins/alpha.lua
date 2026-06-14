return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- -- Stunning ASCII art header
		-- dashboard.section.header.val = {
		-- 	"                                                     ",
		-- 	"  ██╗  ██╗ ██████╗ ███╗   ██╗███████╗██████╗  █████╗ ",
		-- 	"  ██║  ██║██╔═████╗████╗  ██║╚══███╔╝██╔══██╗██╔══██╗",
		-- 	"  ███████║██║██╔██║██╔██╗ ██║  ███╔╝ ██████╔╝███████║",
		-- 	"  ██╔══██║████╔╝██║██║╚██╗██║ ███╔╝  ██╔══██╗██╔══██║",
		-- 	"  ██║  ██║╚██████╔╝██║ ╚████║███████╗██║  ██║██║  ██║",
		-- 	"  ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝",
		-- 	"                                                     ",
		-- 	"    ⚡ Powered by Tokyonight & Lazy.vim - TedAn ⚡   ",
		-- 	"                                                     ",
		-- }

		-- Stunning ASCII art header
		dashboard.section.header.val = {
			"                                                                              ",
			"        ,--,                                                                  ",
			"      ,--.'|    ,----..                                        ,---,          ",
			"   ,--,  | :   /   /   \\                                      '  .' \\       ",
			",---.'|  : '  /   .     :       ,---,        ,----,  __  ,-. /  ;    '.       ",
			"|   | : _' | .   /   ;.  \\  ,-+-. /  |     .'   .`|,' ,'/ /|:  :       \\    ",
			":   : |.'  |.   ;   /  ` ; ,--.'|'   |  .'   .'  .''  | |' |:  |   /\\   \\   ",
			"|   ' '  ; :;   |  ; \\ ; ||   |  ,\"' |,---, '   ./ |  |   ,'|  :  ' ;.   :  ",
			"'   |  .'. ||   :  | ; | '|   | /  | |;   | .'  /  '  :  /  |  |  ;/  \\   \\ ",
			"|   | :  | '.   |  ' ' ' :|   | |  | |`---' /  ;--,|  | '   '  :  | \\  \\ ,' ",
			"'   : |  : ;'   ;  \\; /  ||   | |  |/   /  /  / .`|;  : |   |  |  '  '--'    ",
			"|   | '  ,/  \\   \\  ',  / |   | |--'  ./__;     .' |  , ;   |  :  :         ",
			";   : ;--'    ;   :    /  |   |/      ;   |  .'     ---'    |  | ,'           ",
			"|   ,/         \\   \\ .'   '---'       `---'                 `--''           ",
			"'---'           `---`                                                         ",
			"                                                                              ",
			"                   ⛩  Code • Create • Conquer  ⛩                              ",
			"                                                                              ",
		}

		-- Beautiful menu with icons
		dashboard.section.buttons.val = {
			dashboard.button("n", " New File", "<cmd>ene<CR>"),
			dashboard.button("e", " File Explorer", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("f", "󰱼 Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("r", "󰄉 Recent Files", "<cmd>Telescope oldfiles<CR>"),
			dashboard.button("w", " Find Word", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("s", "󰁯 Restore Session", "<cmd>AutoSession restore<CR>"),
			dashboard.button("l", "󰒲 Lazy", "<cmd>Lazy<CR>"),
			dashboard.button("m", "󰆧 Mason", "<cmd>Mason<CR>"),
			dashboard.button("q", " Quit", "<cmd>qa<CR>"),
		}

		-- Footer with inspiring quote
		local function footer()
			local datetime = os.date(" %Y-%m-%d   %H:%M:%S")
			local version = vim.version()
			local nvim_version = "  Neovim v" .. version.major .. "." .. version.minor .. "." .. version.patch
			
			return datetime .. "\n" .. nvim_version
		end

		dashboard.section.footer.val = footer()
		dashboard.section.footer.opts.hl = "AlphaFooter"
		dashboard.section.header.opts.hl = "AlphaHeader"
		dashboard.section.buttons.opts.hl = "AlphaButtons"

		-- Padding
		dashboard.config.layout = {
			{ type = "padding", val = 2 },
			dashboard.section.header,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			{ type = "padding", val = 1 },
			dashboard.section.footer,
		}

		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
