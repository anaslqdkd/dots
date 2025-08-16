require("neorg").setup({
	load = {
		["core.defaults"] = {}, -- Load all the default modules
		["core.concealer"] = {
			config = {
				icon_preset = "diamond", -- choose a preset below
			},
		},
		["core.dirman"] = { -- Manage multiple workspaces
			config = {
				workspaces = {
					journal = "~/Documents/journal", -- example workspace
					notes = "~/Documents/notes",
				},
				default_workspace = "journal",
			},
		},
		["core.integrations.treesitter"] = {},
		["core.syntax"] = {},
	},
})
