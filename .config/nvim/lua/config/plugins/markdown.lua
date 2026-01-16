return {
	-- Markdown Preview in Browser
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		keys = {
			{
				"<leader>mp",
				ft = "markdown",
				"<cmd>MarkdownPreviewToggle<cr>",
				desc = "Markdown Preview",
			},
		},
		config = function()
			vim.g.mkdp_auto_start = 0
			vim.g.mkdp_auto_close = 1
			vim.g.mkdp_refresh_slow = 0
			vim.g.mkdp_command_for_global = 0
			vim.g.mkdp_open_to_the_world = 0
			vim.g.mkdp_open_ip = ""
			vim.g.mkdp_browser = ""
			vim.g.mkdp_echo_preview_url = 1
			vim.g.mkdp_browserfunc = ""
			vim.g.mkdp_preview_options = {
				mkit = {},
				katex = {},
				uml = {},
				maid = {},
				disable_sync_scroll = 0,
				sync_scroll_type = "middle",
				hide_yaml_meta = 1,
				sequence_diagrams = {},
				flowchart_diagrams = {},
				content_editable = false,
				disable_filename = 0,
				toc = {},
			}
			vim.g.mkdp_markdown_css = ""
			vim.g.mkdp_highlight_css = ""
			vim.g.mkdp_port = ""
			vim.g.mkdp_page_title = "「${name}」"
			vim.g.mkdp_theme = "dark"
		end,
	},

	-- Markdown rendering in Neovim
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			heading = {
				enabled = true,
				sign = true,
				icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
				backgrounds = {
					"RenderMarkdownH1Bg",
					"RenderMarkdownH2Bg",
					"RenderMarkdownH3Bg",
					"RenderMarkdownH4Bg",
					"RenderMarkdownH5Bg",
					"RenderMarkdownH6Bg",
				},
				foregrounds = {
					"RenderMarkdownH1",
					"RenderMarkdownH2",
					"RenderMarkdownH3",
					"RenderMarkdownH4",
					"RenderMarkdownH5",
					"RenderMarkdownH6",
				},
			},
			code = {
				enabled = true,
				sign = false,
				style = "full",
				left_pad = 2,
				right_pad = 2,
				width = "block",
				border = "thin",
			},
			dash = {
				enabled = true,
				icon = "─",
				width = "full",
			},
			bullet = {
				enabled = true,
				icons = { "●", "○", "◆", "◇" },
			},
			checkbox = {
				enabled = true,
				unchecked = { icon = "󰄱 " },
				checked = { icon = "󰱒 " },
			},
			quote = {
				enabled = true,
				icon = "▋",
			},
			pipe_table = {
				enabled = true,
				style = "full",
			},
			callout = {
				note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
				tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
				important = {
					raw = "[!IMPORTANT]",
					rendered = "󰅾 Important",
					highlight = "RenderMarkdownHint",
				},
				warning = {
					raw = "[!WARNING]",
					rendered = "󰀪 Warning",
					highlight = "RenderMarkdownWarn",
				},
				caution = {
					raw = "[!CAUTION]",
					rendered = "󰳦 Caution",
					highlight = "RenderMarkdownError",
				},
			},
		},
		config = function(_, opts)
			require("render-markdown").setup(opts)

			-- Custom highlights for headings
			vim.cmd([[
				highlight RenderMarkdownH1 guifg=#7aa2f7 gui=bold
				highlight RenderMarkdownH2 guifg=#7dcfff gui=bold
				highlight RenderMarkdownH3 guifg=#9ece6a gui=bold
				highlight RenderMarkdownH4 guifg=#e0af68 gui=bold
				highlight RenderMarkdownH5 guifg=#bb9af7 gui=bold
				highlight RenderMarkdownH6 guifg=#f7768e gui=bold
				
				highlight RenderMarkdownH1Bg guibg=#1a2332
				highlight RenderMarkdownH2Bg guibg=#1a2730
				highlight RenderMarkdownH3Bg guibg=#1a2b24
				highlight RenderMarkdownH4Bg guibg=#2b2817
				highlight RenderMarkdownH5Bg guibg=#2a1f30
				highlight RenderMarkdownH6Bg guibg=#2b1f21
				
				highlight RenderMarkdownCode guibg=#143652
				highlight RenderMarkdownCodeInline guibg=#0d2a42 guifg=#9ece6a
				
				highlight RenderMarkdownBullet guifg=#7aa2f7
				highlight RenderMarkdownQuote guifg=#547998
				highlight RenderMarkdownDash guifg=#3b4261
				
				highlight RenderMarkdownSuccess guifg=#9ece6a
				highlight RenderMarkdownInfo guifg=#7aa2f7
				highlight RenderMarkdownHint guifg=#7dcfff
				highlight RenderMarkdownWarn guifg=#e0af68
				highlight RenderMarkdownError guifg=#f7768e
			]])
		end,
	},

	-- Table mode for easy markdown tables
	{
		"dhruvasagar/vim-table-mode",
		ft = { "markdown" },
		config = function()
			vim.g.table_mode_corner = "|"
			vim.g.table_mode_corner_corner = "|"
			vim.g.table_mode_header_fillchar = "-"

			-- Keybindings
			vim.keymap.set("n", "<leader>tm", ":TableModeToggle<CR>", { desc = "Toggle table mode" })
			vim.keymap.set("n", "<leader>tr", ":TableModeRealign<CR>", { desc = "Realign table" })
		end,
	},
}
