local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", ",a", function()
	harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

for i, key in ipairs({ "h", "j", "k", "l" }) do
	vim.keymap.set("n", "<leader>" .. key, function()
		harpoon:list():select(i)
	end, { desc = "Harpoon to file " .. i })
end

vim.keymap.set("n", "<C-S-P>", function()
	harpoon:list():prev()
end)
vim.keymap.set("n", "<C-S-N>", function()
	harpoon:list():next()
end)
