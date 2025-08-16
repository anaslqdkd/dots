require("CopilotChat").setup({
	mapping = {
		["<C-l"] = false,
		["<C-j"] = false,
		["<C-k"] = false,
	},
})
vim.keymap.set("n", "<leader>cc", function()
	require("CopilotChat").toggle()
end, { desc = "Toggle Copilot Chat" })
-- optional config})
