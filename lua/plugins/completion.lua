return {
	{
		"saghen/blink.cmp",
		desc = "Text completion engine",
		version = "*",
		opts = {
			keymap = {
				preset = "default",
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<CR>"] = { "accept", "fallback" },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
	},
	{
		"supermaven-inc/supermaven-nvim",
		desc = "AI code completion and suggestions",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<C-,>",
					clear_suggestion = "<C-/>",
					accept_word = "<C-.>",
				},
			})
		end,
	},
}
