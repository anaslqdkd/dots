vim.api.nvim_set_hl(0, "ObsidianTodo", { bold = true, fg = "#f78c6c" })
vim.api.nvim_set_hl(0, "ObsidianDone", { bold = true, fg = "#89ddff" })
vim.api.nvim_set_hl(0, "ObsidianRightArrow", { bold = true, fg = "#f78c6c" })
vim.api.nvim_set_hl(0, "ObsidianTilde", { bold = true, fg = "#ff5370" })
vim.api.nvim_set_hl(0, "ObsidianImportant", { bold = true, fg = "#d73128" })

require("render-markdown").setup({
	checkbox = {
		enabled = true,
		custom = {
			arrow = { raw = "[>]", rendered = " ", highlight = "ObsidianRightArrow" }, -- Forward arrow
			tilde = { raw = "[~]", rendered = "󰰱 ", highlight = "ObsidianTilde" }, -- Strikethrough
			important = { raw = "[!]", rendered = " ", highlight = "ObsidianImportant" }, -- Important
		},
	},
	opts = {
		latex = { enabled = false },
		win_options = { conceallevel = { rendered = 2 } },
		on = {
			attach = function()
				require("nabla").enable_virt({ autogen = true })
			end,
		},
	},
	-- nnoremap <leader>p :lua require("nabla").popup()<CR> " Customize with popup({border = ...})  : `single` (default), `double`, `rounded`
})
