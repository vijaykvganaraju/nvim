return {
	"nvim-treesitter/nvim-treesitter",
	desc = "Syntax highlighting and parsing",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
	opts = {
		ensure_installed = {
			"javascript",
			"java",
			"rust",
			"python",
			"xml",
			"yaml",
			"bash",
			"lua",
		},
		highlight = { enable = true },
		indent = { enable = true },
	},
}
