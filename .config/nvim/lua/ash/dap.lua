local dap = require("dap")

dap.adapters.python = {
	type = "executable",
	command = "/usr/bin/python3.13",
	args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		-- program = "${file}",
		-- cwd = "/home/ash/pcl-grp31", -- hardcode your project root
		cwd = vim.fn.getcwd(), -- use current working directory
		env = {
			-- PYTHONPATH = "/home/ash/pcl-grp31", -- hardcoded PYTHONPATH
			PYTHONPATH = vim.fn.getcwd(), -- set PYTHONPATH to current working directory
			-- add more env vars here if needed
		},
		pythonPath = function()
			return "/usr/bin/python3.13"
		end,
		console = "integratedTerminal",
		stopOnEntry = true,
		args = { "-m", "debugpy.adapter", "--log-to", "/tmp/debugpy.log" },
		-- program = "/home/ash/pcl-grp31/main.py",
		-- program = function()
		-- 	return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		-- end,
		program = function()
			local config_path = vim.fn.stdpath("data") .. "/dap_program_path.txt"
			local file = io.open(config_path, "r")
			local last_path = file and file:read("*l") or (vim.fn.getcwd() .. "/")
			if file then
				file:close()
			end
			local input = vim.fn.input("Path to executable: ", last_path, "file")
			file = io.open(config_path, "w")
			if file then
				file:write(input)
				file:close()
			end
			return input
		end,
	},
}

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>dc", "<Cmd>lua require'dap'.continue()<CR>", opts)

-- Step over, step into, step out
vim.api.nvim_set_keymap("n", "<F10>", "<Cmd>lua require'dap'.step_over()<CR>", opts)
vim.api.nvim_set_keymap("n", "<F11>", "<Cmd>lua require'dap'.step_into()<CR>", opts)
vim.api.nvim_set_keymap("n", "<F12>", "<Cmd>lua require'dap'.step_out()<CR>", opts)

-- Toggle breakpoint
vim.api.nvim_set_keymap("n", "<leader>db", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)

-- Set conditional breakpoint (prompts for condition)
vim.api.nvim_set_keymap(
	"n",
	"<leader>dB",
	"<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	opts
)

-- Open REPL
vim.api.nvim_set_keymap("n", "<leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>", opts)

-- Run last debug session again
vim.api.nvim_set_keymap("n", "<leader>dl", "<Cmd>lua require'dap'.run_last()<CR>", opts)
