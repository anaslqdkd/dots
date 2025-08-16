local builtin = require("telescope.builtin")
-- vim.keymap.set("n", "<leader>ff", builtin.find_files(), {})
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep >") })
end)

local telescope = require("telescope")
local actions = require("telescope.actions")

-- telescope.setup({
-- 	defaults = {
-- 		mappings = {
-- 			i = {
-- 				["<CR>"] = actions.select_vertical, -- Bind <CR> to open in vertical split
-- 			},
-- 		},
-- 	},
-- })
--

-- :lua require('telescope.builtin').pickers({opts})
