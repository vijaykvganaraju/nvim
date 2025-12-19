vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Go to nvmrc / dir view" })
vim.keymap.set("n", "<leader>po", [["+gp]], { desc = "Paste clipboard content" });

vim.keymap.set("n", "<leader>rn", "<cmd>set rnu!<cr>", { desc = "Toggle Relative Number" })
