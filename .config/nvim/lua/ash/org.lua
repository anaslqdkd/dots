require("orgmode").setup({
	org_agenda_files = "~/orgfiles/**/*",
	org_default_notes_file = "~/orgfiles/refile.org",
	org_fold_enable = false,
	org_capture_templates = {
		n = { -- Note
			description = "Note",
			template = "* %?\n  %u\n",
			target = "~/orgfiles/refile.org",
		},
		t = { -- Task
			description = "Task",
			template = "* TODO %?\n",
			target = "~/orgfiles/todo.org",
		},
		j = {
			description = "Journal Entry",
			template = "* %U %?\n",
			target = "~/orgfiles/journal.org",
			datatree = true, -- ensures entries go under the date tree
		},
		T = {
			description = "Todo for today",
			template = "* TODO %?\nSCHEDULED: <%<%Y-%m-%d %a>>",
			target = "~/orgfiles/todo.org",
		},
		c = {
			description = "Code To-Do",
			template = "* TODO [#B] %?\n:Created: %U\n%a\nProposed Solution: ",
			target = "~/orgfiles/todo.org",
			empty_lines = 0,
		},
	},
})

vim.keymap.set("n", "<leader>op", ":e ~/orgfiles/projects.org<CR>", { desc = "Open Projects Org" })

ts = vim.treesitter

local function get_headlines()
	local parser = ts.get_parser(0, "org")
	local tree = parser:parse()[1]
	local root = tree:root()
	local headlines = {}

	local function walk(node)
		if node:type() == "headline" then
			local text = vim.treesitter.get_node_text(node, 0)
			table.insert(headlines, text)
		end

		for i = 0, node:named_child_count() - 1 do
			walk(node:named_child(i))
		end
	end

	walk(root)
	print(vim.inspect(headlines))

	return headlines
end

local function get_todos(headlines)
	local todos = {}
	for _, hl in ipairs(headlines) do
		local todo, rest = hl:match("^%*+%s+(TODO)%s+(.*)$")
		if todo then
			table.insert(todos, rest)
		else
		end
	end
	print(vim.inspect(todos))
	return todos
end

local function write_json_file(table, path)
	local json = vim.json.encode(table)
	local file = assert(io.open(path, "w"))
	file:write(json)
	file:close()
end

local function save_to_json()
	local headlines = get_headlines()
	local todos = get_todos(headlines)
	write_json_file(todos, "/home/ash/org.json")
	print(json)
end

vim.api.nvim_create_user_command("SaveToJson", save_to_json, {})
require("org-bullets").setup({})
