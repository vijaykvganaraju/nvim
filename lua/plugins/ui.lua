return {
	{ "stevearc/dressing.nvim", desc = "Better UI for vim.ui interfaces", event = "VeryLazy" },
	{ "dstein64/vim-startuptime", desc = "Diagnose startup time using :StartupTime", cmd = "StartupTime" },
	{
		"folke/noice.nvim",
		desc = "Floating pop ups and command line",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{ "nvim-lualine/lualine.nvim", desc = "Status line at bottom", dependencies = { "nvim-tree/nvim-web-devicons" }, opts = {} },
	{ "lukas-reineke/indent-blankline.nvim", desc = "Indentation guides for code", main = "ibl", opts = {} },
}
