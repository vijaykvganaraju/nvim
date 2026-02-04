return {
	"mfussenegger/nvim-jdtls",
	desc = "Java language server and tools",
	ft = "java",
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
	},
	config = function()
		local jdtls = require("jdtls")

		local root_markers = {
			".git",
			"mvnw",
			"gradlew",
			"pom.xml",
			"build.gradle",
		}

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

		local function setup_jdtls()
			local root_dir = jdtls.setup.find_root(root_markers)
			if root_dir == nil then
				vim.notify("jdtls: Could not find project root", vim.log.levels.WARN)
				return
			end

			local workspace_dir = vim.fn.stdpath("data")
				.. "/jdtls-workspaces/"
				.. vim.fn.fnamemodify(root_dir, ":p:h:t")

			jdtls.start_or_attach({
				cmd = {
					"jdtls",
					"--java-executable", "/Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home/bin/java",
				},
				root_dir = root_dir,
				workspace_folder = workspace_dir,
				settings = { java = { configuration = { runtimes = runtimes } } },
			})
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "java",
			callback = setup_jdtls,
		})
	end,
}
