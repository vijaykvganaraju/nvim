return {
	{
		"NickvanDyke/opencode.nvim",
		desc = "OpenCode AI assistant integration",
		dependencies = { "folke/snacks.nvim" },
		config = function()
			vim.g.opencode_opts = {}
			vim.o.autoread = true

			-- OpenCode keymaps (leader o)
			vim.keymap.set({ "n", "t" }, "<leader>ot", function()
				require("opencode").toggle()
			end, { desc = "Toggle OpenCode" })
			vim.keymap.set({ "n", "t" }, "<leader>of", function()
				-- Switch focus between OpenCode terminal and editor
				local win = vim.api.nvim_get_current_win()
				local buf = vim.api.nvim_win_get_buf(win)
				if vim.bo[buf].filetype == "opencode_terminal" then
					vim.cmd("wincmd p") -- Go to previous (editor)
				else
					for _, w in ipairs(vim.api.nvim_list_wins()) do
						local b = vim.api.nvim_win_get_buf(w)
						if vim.bo[b].filetype == "opencode_terminal" then
							vim.api.nvim_set_current_win(w)
							return
						end
					end
					require("opencode").toggle() -- Open if not visible
				end
			end, { desc = "Switch OpenCode/editor focus" })
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
	}
}
