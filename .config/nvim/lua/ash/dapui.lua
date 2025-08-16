local dap, dapui = require("dap"), require("dapui")

dapui.setup() -- use default config or customize here

-- Open dap-ui automatically when debugging starts, close when it ends
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
