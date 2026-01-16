return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		'moll/vim-bbye',
	},
	version = "*",
	config = function()
		require('bufferline').setup {
			options = {
				mode = 'buffers',
				themable = true,
				numbers = 'none',
				close_command = 'Bdelete! %d',
				buffer_close_icon = '×',
				modified_icon = '●',
				close_icon = '×',
				left_trunc_marker = '',
				right_trunc_marker = '',
				max_name_length = 18,
				max_prefix_length = 15,
				tab_size = 20,
				diagnostics = 'nvim_lsp',
				diagnostics_update_in_insert = false,
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
				color_icons = true,
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				persist_buffer_sort = true,
				separator_style = "slant",
				enforce_regular_tabs = false,
				always_show_bufferline = true,
				show_tab_indicators = true,
				indicator = {
					style = 'underline',
				},
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					}
				},
				hover = {
					enabled = true,
					delay = 200,
					reveal = {'close'}
				},
			},
			highlights = {
				fill = {
					bg = 'NONE',
				},
				background = {
					bg = 'NONE',
				},
				buffer_selected = {
					bg = '#1e222a',
					bold = true,
					italic = true,
				},
				buffer_visible = {
					bg = 'NONE',
				},
				close_button = {
					bg = 'NONE',
				},
				close_button_selected = {
					bg = '#1e222a',
				},
				close_button_visible = {
					bg = 'NONE',
				},
				separator = {
					fg = '#1e222a',
					bg = 'NONE',
				},
				separator_selected = {
					fg = '#1e222a',
					bg = '#1e222a',
				},
				separator_visible = {
					fg = '#1e222a',
					bg = 'NONE',
				},
				indicator_selected = {
					fg = '#61afef',
					bg = '#1e222a',
				},
				modified = {
					bg = 'NONE',
				},
				modified_selected = {
					bg = '#1e222a',
				},
				modified_visible = {
					bg = 'NONE',
				},
				diagnostic = {
					bg = 'NONE',
				},
				diagnostic_selected = {
					bg = '#1e222a',
				},
				diagnostic_visible = {
					bg = 'NONE',
				},
			},
		}

		-- Tab: Next buffer
		vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", {
			noremap = true,
			silent = true,
			desc = "Next buffer",
		})

		-- Shift+Tab: Previous buffer
		vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", {
			noremap = true,
			silent = true,
			desc = "Previous buffer",
		})

		-- Space+tx: Close current buffer
		vim.keymap.set("n", "<leader>tx", "<cmd>Bdelete!<CR>", {
			noremap = true,
			silent = true,
			desc = "Close buffer",
		})

		-- Bonus: Space+tX: Close all other buffers
		vim.keymap.set("n", "<leader>tX", "<cmd>BufferLineCloseOthers<CR>", {
			noremap = true,
			silent = true,
			desc = "Close other buffers",
		})
	end,
}
