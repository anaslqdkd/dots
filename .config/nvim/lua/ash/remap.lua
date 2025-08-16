-- General
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>²", vim.cmd.Oil)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- pour bouger un bloc sans pb d'indentation
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- idem

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "C-d", "C-d>zz")
vim.keymap.set("n", "C-u", "C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", '"_dP') -- pour paste au lieu de faire p, plutot faire ,p pour ne pas avoir le mot dans le registre en visuel (sert de remplacement collectif)

vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- pour append un mot

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-J>", "<C-W>j", opts)
vim.keymap.set("n", "<C-K>", "<C-W>k", opts)
vim.keymap.set("n", "<C-L>", "<C-W>l", opts)
vim.keymap.set("n", "<C-H>", "<C-W>h", opts)

-- Git diff view
vim.keymap.set("n", "<leader>gh", ":DiffviewFileHistory<CR>", { desc = "View commits/changes history" })
-- vim.keymap.set("n", "<leader>go", ":DiffviewOpen<CR>", { desc = "Open DiffView " })
vim.keymap.set("n", "<leader>go", function()
	if next(require("diffview.lib").views) == nil then
		vim.cmd("DiffviewOpen")
	else
		vim.cmd("DiffviewClose")
	end
end)

-- Neogit

-- Telescope
vim.keymap.set("n", "<leader>t", ":Telescope<CR>", { desc = "Open Telescope" })

-- Todo Commentary
vim.keymap.set("n", "<leader>do", ":TodoTelescope<CR>", { desc = "Open Telescope To Do in all project" })

-- Fzf
vim.keymap.set("n", "<leader>z", ":FzfLua files<CR>", { desc = "find files with fzf" })

local virtual_text_enabled = true

vim.keymap.set("n", "<leader>e", function()
	virtual_text_enabled = not virtual_text_enabled
	vim.diagnostic.config({
		virtual_text = virtual_text_enabled,
	})
	print("Virtual text " .. (virtual_text_enabled and "enabled" or "disabled"))
end, { desc = "Toggle virtual text in diagnostics" })

-- aerial
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

-- vim.keymap.set("n", "<leader>tb", "Gitsigns toggle_current_line_blame<CR>")

-- terminal
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- nnoremap <leader>p :lua require("nabla").popup()<CR> " Customize with popup({border = ...})  : `single` (default), `double`, `rounded`
-- vim.api.nvim_set_keymap(
-- 	"v",
-- 	"<leader>$",
-- 	":lua require('nabla').popup({border = 'single'})<CR>",
-- 	{ noremap = true, silent = true }
-- )

vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
vim.api.nvim_set_keymap("n", "<Leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>gr", "<Cmd>Trouble lsp_references<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
