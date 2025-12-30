return {
	"mfussenegger/nvim-dap",
	desc = "Debug adapter protocol for debugging",
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
		
		dap.set_log_level('TRACE')
		
		-- Java DAP adapter (for attach debugging)
		-- Simple server adapter that connects to running Java debug port
		dap.adapters.java = function(callback, config)
			callback({
				type = 'server',
				host = config.hostName or '127.0.0.1',
				port = config.port or 5005,
			})
		end
		
		-- Java DAP configuration
		dap.configurations.java = {
			{
				type = 'java',
				request = 'attach',
				name = "Attach to Java (port 5005)",
				hostName = "127.0.0.1",
				port = 5005,
			},
		}
		
		-- Empty configs for UI buffers to prevent errors
		dap.configurations.snacks_picker_list = {}
		dap.configurations.snacks_explorer = {}
		
		-- Auto open/close UI
		dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
		dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
		dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
	end,
}
