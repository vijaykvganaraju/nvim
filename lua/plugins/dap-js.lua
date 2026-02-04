return {
	"mxsdev/nvim-dap-vscode-js",
	desc = "JavaScript and TypeScript debugging support",
	dependencies = { "mfussenegger/nvim-dap" },
	lazy = false,
	config = function()
		local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
		require("dap-vscode-js").setup({
			node_path = "node",
			debugger_path = mason_path .. "/js-debug-adapter",
			adapters = { "pwa-node" },
		})

		local dap = require("dap")
		for _, adapter in pairs({ "pwa-node", "pwa-chrome" }) do
			dap.adapters[adapter] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "js-debug-adapter",
					args = { "${port}" },
				},
			}
		end
		
		-- Simple configs for Node.js (including React files)
		for _, lang in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
			dap.configurations[lang] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Debug Current File",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "npm run start:dev",
					runtimeExecutable = "npm",
					runtimeArgs = { "run", "start:dev" },
					cwd = "${workspaceFolder}",
				},
			}
		end
	end,
}
