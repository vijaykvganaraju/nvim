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
		opts = {},
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
	{ "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
	{
		"stevearc/conform.nvim",
		event = { "BufReadPost" },
		cmd = { "ConformInfo" },
		keys = {
			{ "<leader>cf", function() require("conform").format({ async = true }) end, desc = "Format buffer" },
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				rust = { "rustfmt" },
				java = { "google-java-format" },
				["*"] = { "trim_whitespace" },
			},
		},
	},
	
	-- Navigation
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		opts = {},
	},

	-- Completion engine (alternative to nvim-cmp)
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

			local runtimes = {
				{
					name = "JavaSE-1.8",
					path = "/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home",
				},
				{
					name = "JavaSE-11",
					path = "/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home",
				},
				{
					name = "JavaSE-17",
					path = "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home",
				},
				{
					name = "JavaSE-21",
					path = "/Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home",
					default = true,
				},
			}

			-- Start or attach jdtls
			jdtls.start_or_attach({
				cmd = {
					"jdtls",
					"--java-executable", "/Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home/bin/java",
				},
				root_dir = root_dir,
				workspace_folder = workspace_dir,
				settings = { java = { configuration = { runtimes = runtimes } } },
			})
		end,
	},

	-- Debug Adapter Protocol
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()
			require("nvim-dap-virtual-text").setup()
			
			dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
			dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
			dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
		end,
	},

	-- Python DAP
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dap-python").setup("python")
		end,
	},

	-- JavaScript/TypeScript DAP
	{
		"mxsdev/nvim-dap-vscode-js",
		ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dap-vscode-js").setup({
				debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
				adapters = { "pwa-node", "pwa-chrome" },
			})

			-- Configure for Node.js
			for _, lang in ipairs({ "javascript", "typescript" }) do
				require("dap").configurations[lang] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
				}
			end
		end,
	},
}

