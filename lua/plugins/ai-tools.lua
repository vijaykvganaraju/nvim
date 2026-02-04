return {
	{
		"NickvanDyke/opencode.nvim",
		desc = "OpenCode AI assistant integration",
		dependencies = { "folke/snacks.nvim" },
		config = function()
			vim.g.opencode_opts = {}
			vim.o.autoread = true

			-- Auto-reload files when changed externally (e.g., by OpenCode)
			vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
				pattern = "*",
				callback = function()
					if vim.fn.getcmdwintype() == "" then
						vim.cmd("checktime")
					end
				end,
			})

			-- OpenCode keymaps (leader o for normal mode, Alt+key for terminal mode)
			-- Toggle OpenCode
			vim.keymap.set("n", "<leader>ot", function()
				require("opencode").toggle()
			end, { desc = "Toggle OpenCode" })
			vim.keymap.set("t", "<M-o>", function()
				require("opencode").toggle()
			end, { desc = "Toggle OpenCode" })

			-- Switch focus between OpenCode terminal and editor (only if already open)
			local function switch_opencode_focus()
				local cur_buf = vim.api.nvim_get_current_buf()

				-- If we're in a terminal, go back to editor
				if vim.bo[cur_buf].buftype == "terminal" then
					vim.cmd("wincmd p")
					return
				end

				-- Search all buffers for terminal with a visible window
				for _, b in ipairs(vim.api.nvim_list_bufs()) do
					if vim.api.nvim_buf_is_valid(b) and vim.bo[b].buftype == "terminal" then
						for _, w in ipairs(vim.api.nvim_list_wins()) do
							if vim.api.nvim_win_get_buf(w) == b then
								vim.api.nvim_set_current_win(w)
								vim.schedule(function()
									vim.cmd("startinsert")
								end)
								return
							end
						end
					end
				end

				-- No visible terminal found - do nothing (use <leader>ot to open)
			end
			vim.keymap.set("n", "<leader>of", switch_opencode_focus, { desc = "Switch OpenCode/editor focus" })
			vim.keymap.set("t", "<M-f>", switch_opencode_focus, { desc = "Switch OpenCode/editor focus" })
			vim.keymap.set({ "n", "x" }, "<leader>oa", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask OpenCode" })
			vim.keymap.set({ "n", "x" }, "<leader>os", function()
				require("opencode").select()
			end, { desc = "OpenCode select" })
			vim.keymap.set({ "n", "x" }, "<leader>oo", function()
				return require("opencode").operator("@this ")
			end, { desc = "Add range to OpenCode", expr = true })
			vim.keymap.set("n", "<leader>ol", function()
				return require("opencode").operator("@this ") .. "_"
			end, { desc = "Add line to OpenCode", expr = true })
			vim.keymap.set("n", "<leader>ou", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "OpenCode scroll up" })
			vim.keymap.set("n", "<leader>od", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "OpenCode scroll down" })
		end,
	},
	{
		"yetone/avante.nvim",
		desc = "AI chat and code assistant",
		build = vim.fn.has("win32") ~= 0
			and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
			or "make",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			"stevearc/dressing.nvim",
		},
		opts = {
			behaviour = {
				auto_suggestions = true,
			},
			mappings = {
				suggestion = {
					accept = "<C-,>",
					dismiss = "<C-/>",
					next = "<M-]>",
					prev = "<M-[>",
				},
			},
		},
	},
}
