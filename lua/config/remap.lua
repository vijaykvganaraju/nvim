vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Go to nvmrc / dir view" })
vim.keymap.set("n", "<leader>po", [["+gp]], { desc = "Paste clipboard content" });

vim.keymap.set("n", "<leader>rn", "<cmd>set rnu!<cr>", { desc = "Toggle Relative Number" })
vim.keymap.set("n", "<leader>tw", "<cmd>set wrap!<cr>", { desc = "Toggle Wrap" })
vim.keymap.set("n", "<leader>th", "<cmd>set hlsearch!<cr>", { desc = "Toggle search highlights" })

-- Interactive search and replace
vim.keymap.set("n", "<leader>sr", function()
	local pattern = vim.fn.input("Search: ")
	if pattern == "" then
		return
	end
	local replacement = vim.fn.input("Replace with: ")
	vim.cmd("%s/" .. vim.fn.escape(pattern, "/") .. "/" .. vim.fn.escape(replacement, "/") .. "/gc")
end, { desc = "Search and replace (interactive)" })

vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Diagnostics list" })

-- Resize windows with Option + Arrow keys
vim.keymap.set("n", "<M-Up>", "<cmd>resize +2<cr>", { desc = "Increase height" })
vim.keymap.set("n", "<M-Down>", "<cmd>resize -2<cr>", { desc = "Decrease height" })
vim.keymap.set("n", "<M-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease width" })
vim.keymap.set("n", "<M-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase width" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Snacks Picker    
vim.keymap.set("n", "<leader>ff", function() require("snacks").picker.files() end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", function() require("snacks").picker.grep() end, { desc = "Grep" })
vim.keymap.set("n", "<leader>fb", function() require("snacks").picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fr", function() require("snacks").picker.recent() end, { desc = "Recent Files" })
vim.keymap.set("n", "<leader>fw", function() require("snacks").picker.grep_word() end, { desc = "Grep Word" })

-- Harpoon
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>ah", function() harpoon:list():add() end, { desc = "Harpoon add file" })
vim.keymap.set("n", "<leader>ar", function() harpoon:list():remove() end, { desc = "Harpoon remove file" })
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })

-- Gitsigns
local gs = require("gitsigns")
vim.keymap.set("n", "]c", gs.next_hunk, { desc = "Next git change" })
vim.keymap.set("n", "[c", gs.prev_hunk, { desc = "Prev git change" })
vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>hb", gs.blame_line, { desc = "Blame line" })

-- DAP (Debugger) - Simple workflow:
-- 1. Set breakpoint (<leader>b)
-- 2. Start debugging (F5)
-- 3. Step through code (F10/F11)
-- 4. Stop debugging (F6)
local dap = require("dap")
local dapui = require("dapui")

-- Essential keymaps only
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/Continue" })
vim.keymap.set("n", "<F6>", function()
	dap.terminate()
	-- Auto cleanup after 1 second
	vim.defer_fn(function()
		vim.fn.system("lsof -ti:8123 | xargs kill 2>/dev/null")
		vim.fn.system("lsof -ti:5005 | xargs kill 2>/dev/null")
		vim.fn.system("lsof -ti:8080 | xargs kill 2>/dev/null")
	end, 1000)
end, { desc = "Stop" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle UI" })
vim.keymap.set("n", "<leader>dc", function()
	dap.goto_()
	vim.cmd("normal! zz")  -- Center screen on cursor
end, { desc = "Go to current debug line" })
vim.keymap.set("n", "<leader>ds", function()
	-- Open telescope picker for stack frames if available, otherwise use builtin
	local ok, telescope = pcall(require, "telescope")
	if ok then
		require('telescope').extensions.dap.frames()
	else
		dapui.float_element('stacks', { enter = true })
	end
end, { desc = "Show call stack" })
vim.keymap.set("n", "<leader>db", function()
	dap.list_breakpoints()
	vim.cmd("copen")
end, { desc = "List all breakpoints" })
vim.keymap.set("n", "<leader>dx", function()
	-- Quick cleanup for stuck processes
	vim.fn.system("lsof -ti:8123 | xargs kill 2>/dev/null")
	vim.fn.system("lsof -ti:5005 | xargs kill 2>/dev/null")
	vim.notify("Cleaned up debugger processes", vim.log.levels.INFO)
end, { desc = "Cleanup stuck debuggers" })
vim.keymap.set("n", "<leader>dl", "<cmd>DapShowLog<cr>", { desc = "Show debug log" })

-- LazyGit
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- Supermaven keymaps (configured in spec1.lua plugin setup)
-- <C-,> - Accept suggestion (insert mode)
-- <C-.> - Accept word (insert mode)
-- <C-/> - Clear suggestion (insert mode)

-- LSP keymaps
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
