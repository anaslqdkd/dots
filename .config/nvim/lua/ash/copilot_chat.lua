require("CopilotChat").setup({
	mapping = {
		["<C-l"] = false,
		["<C-j"] = false,
		["<C-k"] = false,
	},
	-- model = "claude-3.5-sonnet", -- AI model to use
	temperature = 0.1, -- Lower = focused, higher = creative
	window = {
		layout = "vertical", -- 'vertical', 'horizontal', 'float'
		width = 0.5, -- 50% of screen width
	},
	-- auto_insert_mode = true, -- Enter insert mode when opening
	-- system_prompt = "You are a concise AI assistant. Give short, direct answers without code examples unless explicitly requested. Act like a search engine - provide quick answers and references.",
})
vim.keymap.set("n", "<leader>cc", function()
	require("CopilotChat").toggle()
end, { desc = "Toggle Copilot Chat" })
-- optional config})
