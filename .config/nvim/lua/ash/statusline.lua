-- local icons = require("icons")

local M = {}
local clients_lsp = function()
	local bufnr = vim.api.nvim_get_current_buf()

	local clients = vim.lsp.get_clients({ bufnr })
	if next(clients) == nil then
		return ""
	end

	local c = {}
	for _, client in pairs(clients) do
		table.insert(c, client.name)
	end
	return "\u{f085} " .. table.concat(c, " | ")
end

function M.render()
	local mode = M.mode_component()
	local lsp_info = clients_lsp()

	local mode_colors = {
		normal = { fg = "#B3A2E0", bg = "#000000" }, -- Blue text on white background
		insert = { fg = "#E2E6AF", bg = "#000000" }, -- Green text on white background
		visual = { fg = "#FCD2DE", bg = "#000000" }, -- Purple text on white background
		command = { fg = "#80EF80", bg = "#000000" }, -- Orange text on white background
		replace = { fg = "#FF4500", bg = "#000000" }, -- Red text on white background
		unknown = { fg = "#FFFFFF", bg = "#000000" }, -- Dark gray text on white background
		terminal = { fg = "#ff3c82", bg = "#000000" }, -- Dark gray text on white background
	}
	local colors = mode_colors[mode] or mode_colors.unknown
	local text_highlight = "StatuslineText" -- Highlight group for the mode text
	vim.api.nvim_set_hl(0, text_highlight, { fg = colors.fg, bg = colors.bg })

	local git_branch = "%{FugitiveHead()}"
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local filetype = vim.bo.filetype or "unknown"

	local components = {
		string.format("%%#%s# -- ", text_highlight),
		string.format("%%#%s#%s", text_highlight, mode),
		string.format("%%#%s# --", text_highlight),
		"   ",
		"%t",
		"   ",
		string.format(" %%#%s# %s", text_highlight, git_branch),
		"       ",
		string.format("%%#%s# %s", text_highlight, lsp_info),
		"   ",
		"%=",
		string.format("%%#%s#Filetype: %s", text_highlight, filetype),
		"   ",
		-- TODO: à faire un if pour le git branch en fonction du signal
		"   ",
		string.format("%%#%s#%d/%d", text_highlight, current_line, total_lines),
	}

	return table.concat(components)
end

function M.mode_component()
	local mode_to_str = {
		["n"] = "normal",
		["no"] = "op-pending",
		["nov"] = "op-pending",
		["noV"] = "op-pending",
		["no\22"] = "op-pending",
		["niI"] = "normal",
		["niR"] = "normal",
		["niV"] = "normal",
		["nt"] = "normal",
		["ntT"] = "normal",
		["v"] = "visual",
		["vs"] = "visual",
		["V"] = "visual",
		["Vs"] = "visual",
		["\22"] = "visual",
		["\22s"] = "visual",
		["s"] = "select",
		["S"] = "select",
		["\19"] = "select",
		["i"] = "insert",
		["ic"] = "insert",
		["ix"] = "insert",
		["R"] = "replace",
		["Rc"] = "replace",
		["Rx"] = "replace",
		["Rv"] = "virt replace",
		["Rvc"] = "virt replace",
		["Rvx"] = "virt replace",
		["c"] = "command",
		["cv"] = "vim ex",
		["ce"] = "ex",
		["r"] = "prompt",
		["rm"] = "more",
		["r?"] = "confirm",
		["!"] = "shell",
		["t"] = "terminal",
	}
	local current_mode = vim.api.nvim_get_mode().mode
	return mode_to_str[current_mode] or "UNKNOWN"
end

vim.o.statusline = "%!v:lua.require('ash.statusline').render()"

return M
