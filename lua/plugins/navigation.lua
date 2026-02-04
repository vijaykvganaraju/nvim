return {
	{
		"folke/snacks.nvim",
		desc = "File explorer and picker interface",
		priority = 1000,
		lazy = false,
		opts = { picker = {}, explorer = { preset = "sidebar", preview = "main" }, bigfile = {} },
		keys = {
			{ "<leader>e", function() require("snacks").explorer() end, desc = "File Explorer" },
		},
	},
	{
		"ThePrimeagen/harpoon",
		desc = "Quick file navigation and marking",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		opts = {},
	},
}
