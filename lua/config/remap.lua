vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Go to nvmrc / dir view" })
vim.keymap.set("n", "<leader>po", [["+gp]], { desc = "Paste clipboard content" });

vim.keymap.set("n", "<leader>rn", "<cmd>set rnu!<cr>", { desc = "Toggle Relative Number" })
vim.keymap.set("n", "<leader>tw", "<cmd>set wrap!<cr>", { desc = "Toggle Wrap" })

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

-- Harpoon (moved to leader + number)
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

-- DAP (Debugger)
local dap = require("dap")
local dapui = require("dapui")
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
vim.keymap.set("n", "<leader>dB", function()
	require("dap").list_breakpoints()
	vim.cmd("copen")
end, { desc = "List Breakpoints" })

-- Java Debug (jdtls)
vim.keymap.set("n", "<leader>dm", function() require("jdtls").test_nearest_method() end, { desc = "Debug Test Method" })
vim.keymap.set("n", "<leader>dC", function() require("jdtls").test_class() end, { desc = "Debug Test Class" })

-- LazyGit
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- Supermaven keymaps (configured in spec1.lua plugin setup)
-- <C-,> - Accept suggestion (insert mode)
-- <C-.> - Accept word (insert mode)
-- <C-/> - Clear suggestion (insert mode)
