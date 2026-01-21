return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason and mason-lspconfig
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

		-- setup mason UI
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- LSP servers YOU actually need
		mason_lspconfig.setup({
			ensure_installed = {
				"clangd",  -- C / C++
				"pyright", -- Python
				"bashls",  -- Shell
				"lua_ls",  -- Neovim config
			},
			automatic_installation = true,
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"prettier",
				"stylua",
			}
		})
	end,
}
