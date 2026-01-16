return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Keymaps when LSP attaches
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

				vim.keymap.set("n", "dn", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "dp", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "de", vim.diagnostic.open_float, opts)
			end,
		})

		-- LSP server configuration (modern API)
		vim.lsp.config("clangd", {
			capabilities = capabilities,
		})

		vim.lsp.config("pyright", {
			capabilities = capabilities,
		})

		vim.lsp.config("bashls", {
			capabilities = capabilities,
		})

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = { enable = false },
				},
			},
		})

		-- Enable servers
		vim.lsp.enable({
			"clangd",
			"pyright",
			"bashls",
			"lua_ls",
		})
	end,
}

