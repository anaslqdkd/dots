-- local config = {
-- 	cmd = { "/home/ash/.local/share/nvim/mason/bin/jdtls" },
-- 	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
-- }
-- require("jdtls").start_or_attach(config)
--
local javafx_path = "/home/ash/.local/share/javafx/javafx-sdk-23.0.1/lib" -- Path to your JavaFX SDK lib folder

local config = {
	cmd = { "/home/ash/.local/share/nvim/mason/bin/jdtls" },
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", "mvnw" }, { upward = true })[1]),

	-- Configure JavaFX modules and classpath for LSP
	init_options = {
		jvm_args = {
			"--add-modules=ALL-SYSTEM",
			"--add-opens",
			"java.base/java.util=ALL-UNNAMED",
			"--add-opens",
			"java.base/java.lang=ALL-UNNAMED",

			-- Add JavaFX modules
			"--module-path",
			javafx_path,
			"--add-modules",
			"javafx.controls,javafx.fxml", -- add other modules if needed
		},
	},

	settings = {
		java = {
			project = {
				referencedLibraries = vim.fn.glob(javafx_path .. "/*.jar", 1, 1),
			},
		},
	},
}

require("jdtls").start_or_attach(config)
