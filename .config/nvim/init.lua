require("ash.plugins")
require("ash.settings")
require("ash.remap")
require("ash.treesitter")
require("ash.lsp")
require("ash.oil")
require("ash.autopairs")
require("ash.leap")
require("ash.conform")
require("ash.vimtex")
require("lspconfig").css_variables.setup({})
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
-- require("timekeeper")
-- For init.lua
local nvim_lsp = require("lspconfig")
vim.g.vimtex_quickfix_mode = 0
vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site")

nvim_lsp.clangd.setup({})

-- Optional: Use nvim-lsp-installer to automatically install LSP servers
require("lspconfig").clangd.setup({})
local lspconfig = require("lspconfig")

lspconfig.clangd.setup({
	cmd = { "clangd", "--compile-commands-dir=./build" },
	root_dir = function()
		return vim.loop.cwd()
	end,
})
vim.filetype.add({
	pattern = {
		[".*%.fxml$"] = "xml", -- Associate .fxml with XML filetype
	},
})

vim.diagnostic.config({
	virtual_text = true, -- Show diagnostic messages inline with code
	signs = true, -- Show diagnostic signs in the gutter
	underline = true, -- Underline errors and warnings
	severity_sort = true, -- Sort diagnostics by severity
	update_in_insert = false, -- Don't update diagnostics in insert mode
})

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "java",
-- 	callback = function()
-- 		for _, client in pairs(vim.lsp.get_active_clients()) do
-- 			if client.name == "java_language_server" then
-- 				client.stop()
-- 			end
-- 		end
-- 	end,
-- })
--
--

lspconfig.gdscript.setup({})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		-- Check if the window is already split horizontally, and if so, change it to a vertical split
		if vim.fn.winnr("$") > 1 then
			vim.cmd("wincmd L")
		else
			vim.cmd("vertical split")
		end
	end,
})

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.cmd('normal! g`"zz')
		end
	end,
})

-- Show cursorline only on active windows
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

-- Auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "typst",
	callback = function()
		vim.bo.commentstring = "// %s"
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.typ",
	callback = function()
		local input_file = vim.fn.expand("%") -- Get the full path of the current file
		local output_file = vim.fn.expand("%:p:h") .. "/pdfs/" .. vim.fn.expand("%:t:r") .. ".pdf" -- Construct the output file path in the pdfs directory

		-- Ensure the pdfs directory exists
		vim.fn.system("mkdir -p " .. vim.fn.expand("%:p:h") .. "/pdfs")

		-- Compile the Typst file and output the PDF to the pdfs directory
		vim.fn.system("typst compile " .. input_file .. " " .. output_file)
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
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = { "*.*" },
	desc = "load view (folds), when opening file",
	command = "silent! loadview",
})
-- TODO: put a visual element in oil to know that i am in the file editor and
-- not in an actual file

local function to_org()
	vim.cmd("TodoQuickFix")
	local todos = vim.fn.getqflist()
	print(vim.inspect(todos))
end
vim.api.nvim_create_user_command("ToOrg", to_org, {})
