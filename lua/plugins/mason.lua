return {
	{
		"williamboman/mason.nvim",
		desc = "Package manager for LSP servers",
		opts = {
			ensure_installed = {
				-- LSP Servers
				"pyright",
				"ts-standard",
				"typescript-language-server",
				"eslint-lsp",
				"rust-analyzer",
				"jdtls",
				"java-debug-adapter",
				"js-debug-adapter",
				"lua-language-server",
			"json-lsp",
				-- Formatters (required for conform.nvim)
				"prettier",              -- JSON, JS, TS, YAML, HTML, CSS
				"stylua",                -- Lua
				"black",                 -- Python
				"rustfmt",               -- Rust
				"google-java-format",    -- Java
			},
			-- Auto-update installed packages
			auto_update = false,
			-- Auto-install on startup
			automatic_installation = true,
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		desc = "Bridge lsp servers and neovim lsp client",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"pyright",
				"typescript-language-server",
				"eslint",
				"rust_analyzer",
				"lua_ls",
				"jsonls",
			},
			automatic_enable = { exclude = { "jdtls" } },
		},
	},
}
