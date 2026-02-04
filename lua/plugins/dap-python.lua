return {
	"mfussenegger/nvim-dap-python",
	desc = "Python debugging support for DAP",
	ft = "python",
	dependencies = { "mfussenegger/nvim-dap" },
	config = function()
		require("dap-python").setup("python")
	end,
}
