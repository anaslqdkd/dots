require("trouble").setup({
	-- win = {
	-- 	position = "right",
	-- },
})
vim.api.nvim_set_keymap("n", "<leader>m", "<cmd>Trouble todo toggle focus=true<CR>", { noremap = true, silent = true })
