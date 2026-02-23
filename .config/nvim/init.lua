require("ash.plugins")
require("ash.settings")
require("ash.remap")
require("ash.treesitter")
require("ash.lsp")
require("ash.oil")
require("ash.autopairs")
require("ash.conform")
require("ash.vimtex")
require("ash.aerial")
require("ash.ibl")
-- require("ash.image")
require("ash.todo-comments")
require("ash.myplugin")
-- require("ash.noice")
require("ash.plantuml")
-- require("ash.statusline")
require("ash.gitsigns")
-- require("ash.persistence")
-- require("ash.obsidian")
-- require("ash.markdown")
require("ash.markdown-render")
require("ash.ufo")
require("ash.trouble")
require("ash.dap")
require("ash.dapui")
require("ash.copilot_chat")
require("ash.transparent")
require("ash.typst")
require("ash.harpoon")
require("ash.org")
require("ash.fn")

-- require("timekeeper")
vim.g.vimtex_quickfix_mode = 0
vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site")

vim.filetype.add({
	pattern = {
		[".*%.fxml$"] = "xml",
	},
})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	severity_sort = true,
	update_in_insert = false,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		if vim.fn.winnr("$") > 1 then
			vim.cmd("wincmd L")
		else
			vim.cmd("vertical split")
		end
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.cmd('normal! g`"zz')
		end
	end,
})

vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	callback = function()
		if vim.w.auto_cursorline then
			vim.wo.cursorline = true
			vim.w.auto_cursorline = false
		end
	end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	callback = function()
		if vim.wo.cursorline then
			vim.w.auto_cursorline = true
			vim.wo.cursorline = false
		end
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "org",
    callback = function()
        vim.cmd("setlocal foldlevel=99")
		print("Setting the level to 99")
    end,
})


vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "typst",
	callback = function()
		vim.bo.commentstring = "// %s"
	end,
})

vim.g.WMGraphviz_output = "svg"
-- vim.api.nvim_create_autocmd("VimLeave", {
-- 	pattern = "*.tex",
-- 	command = "VimtexClean!",
-- })

vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
	pattern = { "*.*" },
	desc = "save view (folds), when closing file",
	command = "mkview",
})

vim.api.nvim_create_autocmd({"BufWinEnter"}, {
	pattern = {"*.tsx", "*.js", "*.ts", "*.jsx"},
	callback = function()
		vim.opt.shiftwidth = 2
		vim.opt.tabstop = 2
	end,
})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = { "*.*" },
	desc = "load view (folds), when opening file",
	command = "silent! loadview",
})

local function to_org()
	vim.cmd("TodoQuickFix")
	local todos = vim.fn.getqflist()
	print(vim.inspect(todos))
end
vim.api.nvim_create_user_command("ToOrg", to_org, {})

require("snacks").setup({
	input = {},
	picker = {},
	terminal = {},
})
vim.o.autoread = true
vim.keymap.set({ "n", "x" }, "<leader>ot", function()
	require("opencode").ask("@this: ", { submit = true })
end, { desc = "Ask opencode" })
vim.keymap.set({ "n", "x" }, "<leader>ox", function()
	require("opencode").select()
end, { desc = "Execute opencode action…" })
vim.keymap.set({ "n", "t" }, "<leader>or", function()
	require("opencode").toggle()
end, { desc = "Toggle opencode" })

vim.keymap.set({ "n", "x" }, "go", function()
	return require("opencode").operator("@this ")
end, { expr = true, desc = "Add range to opencode" })
vim.keymap.set("n", "goo", function()
	return require("opencode").operator("@this ") .. "_"
end, { expr = true, desc = "Add line to opencode" })

vim.keymap.set("n", "<leader>ou", function()
	require("opencode").command("session.half.page.up")
end, { desc = "opencode half page up" })
vim.keymap.set("n", "<leader>od", function()
	require("opencode").command("session.half.page.down")
end, { desc = "opencode half page down" })


vim.g.opencode_opts = {
	provider = {
		enabled = "tmux",
		tmux = {
			-- ...
		},
	},
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<C-Space>", ':lua require("ash.fn").toggle_checkbox()<CR>', {noremap=true, silent=true})
  end,
})


vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set("n", "<CR>", function()
      require("ash.fn").continue_checkbox_normal()
    end, {buffer = true, noremap=true, silent=true})
  end,
})

vim.g.startify_bookmarks = {
	{ a = '~/.config/nvim/init.lua' },
	{ b = '~/.config/hypr/hyprland.conf' },
	{ c = '~/home-manager/modules/packages.nix' },
}
vim.g.startify_lists = {
    { type = 'bookmarks', header = { '   Bookmarks' } },
    { type = 'files',     header = { '   MRU' } },
}

