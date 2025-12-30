return {
	"neovim/nvim-lspconfig",
	desc = "Language server protocol configuration",
	config = function()
		-- Lua
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		-- Python
		vim.lsp.config("pyright", {})

		-- JS / TS
		vim.lsp.config("typescript-language-server", {
			cmd = {
				"typescript-language-server",
				"--stdio",
			},
			env = {
				PATH = vim.fn.expand("~/.local/bin") .. ":" .. (vim.env.PATH or ""),
			},
		})

		-- ESLint
		vim.lsp.config("eslint", {
			env = {
				PATH = vim.fn.expand("~/.local/bin") .. ":" .. (vim.env.PATH or ""),
			},
			settings = {
				eslint = {
					workingDirectories = { mode = "auto" },
				},
			},
		})

		-- Rust
		vim.lsp.config("rust_analyzer", {})

		-- Java is handled by nvim-jdtls plugin
	end,
}
