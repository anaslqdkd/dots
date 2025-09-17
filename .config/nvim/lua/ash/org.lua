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
