return {
	-- Colorscheme: Set priority so it loads first
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		config = function()
			vim.cmd("colorscheme carbonfox") -- Or nightfox, duskfox, etc.
		end,
	},
	{
		"folke/snacks.nvim", priority = 1000, lazy = false,
		opts = { picker = {}, explorer = { preset = "sidebar", preview = "main" }, bigfile = {} },
		keys = {
			{ "<leader>e", function() require("snacks").explorer() end, desc = "File Explorer" },
		},
	},
    { "lewis6991/gitsigns.nvim", opts = {} },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- leave empty for defaults, or customize later
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
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
	},

	-- UI
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	{ "dstein64/vim-startuptime", desc = "Diagnose startup time using :StartupTime", cmd = "StartupTime" },
	{
		"folke/noice.nvim",
		desc = "Floating pop ups and command line",
		event = "VeryLazy",
		opts = {
			-- add any custom noice options here
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, opts = {} },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

	-- Text Manipulation
	{
		"Wansmer/treesj",
		keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
		opts = { use_default_keymaps = false, max_join_length = 150 },
	},
	{
		"monaqa/dial.nvim",
		keys = { "<C-a>", { "<C-x>", mode = "n" } },
	},
	{
		"echasnovski/mini.nvim", version = "*",
		desc = "Adds pairing brackets, quotes etc.",
		config = function()
			require("mini.surround").setup()
			require("mini.ai").setup()
		end
	},
    { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },

	-- Completion engine (alternative to nvim-cmp)
	{
		"saghen/blink.cmp",
		desc = "Text completion engine",
		version = "*",
		opts = {
			keymap = { preset = "default" },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
	},

	-- Tools for managing LSP servers
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"pyright",       -- Python
				"ts-standard",   -- JS/TS Linter
				"ts_ls", -- JS/TS LSP
				"rust-analyzer", -- Rust
				"jdtls",         -- Java
				"lua-language-server", -- Lua
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		desc = "Bridge lsp servers and neovim lsp client",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"pyright",
				"ts_ls",
				"rust_analyzer",
				"lua_ls",
			},
			automatic_enable = { exclude = { "jdtls" } },
		},
	},

	-- Core LSP Configuration
	{
		"neovim/nvim-lspconfig",
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
			vim.lsp.config("ts_ls", {})

			-- Rust
			vim.lsp.config("rust_analyzer", {})

			-- Java
			vim.lsp.config("jdtls", {})
		end,
	},

	-- Java configs
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
		},
		config = function()
			local jdtls = require("jdtls")

			-- Detect project root
			local root_markers = {
				".git",
				"mvnw",
				"gradlew",
				"pom.xml",
				"build.gradle",
			}

			local root_dir = jdtls.setup.find_root(root_markers)
			if root_dir == nil then
				return
			end

			-- Workspace directory (one per project)
			local workspace_dir = vim.fn.stdpath("data")
			.. "/jdtls-workspaces/"
			.. vim.fn.fnamemodify(root_dir, ":p:h:t")

			-- Start or attach jdtls
			jdtls.start_or_attach({
				cmd = { "jdtls" },
				root_dir = root_dir,
				workspace_folder = workspace_dir,
			})
		end,
	},
}

