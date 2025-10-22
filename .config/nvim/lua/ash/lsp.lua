local lsp_zero = require("lsp-zero")
-- local lspconfig = require("lspconfig")

-- lspconfig.csharp_ls.setup({})
-- require'lspconfig'.csharp_ls.setup{}
-- lspconfig.csharp_ls.setup({
-- 	root_dir = lspconfig.util.root_pattern(".git", ".csproj", "packages.config"),
-- })

-- lspconfig.csharp_ls.setup({
-- 	root_dir = lspconfig.util.root_pattern(".git", ".csproj", "packages.config"),
-- 	cmd = { "/home/ash/.dotnet/tools/csharp-ls" }, -- Ensure cmd path is correct
-- 	filetypes = { "cs" }, -- Specify file types to activate csharp_ls
-- 	autostart = true, -- Automatically start the language server
-- 	custom_handlers = {}, -- Optional: Define custom handlers if needed
-- })

lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

require("mason").setup({})
require("mason-lspconfig").setup({
	handlers = {
		lsp_zero.default_setup,
	},
})
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

local luasnip = require("luasnip")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<Right>"] = cmp.mapping(function(fallback)
			if vim.fn["copilot#Accept"] and vim.fn["copilot#Accept"]("") ~= "" then
				vim.api.nvim_feedkeys(vim.fn["copilot#Accept"](), "i", true)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "orgmode" },
	}),
})

-- vim.lsp.config.rust_analyzer.setup({
-- 	on_attach = function(_, bufnr)
-- 		local function buf_set_keymap(...)
-- 			vim.api.nvim_buf_set_keymap(bufnr, ...)
-- 		end
-- 		local opts = { noremap = true, silent = true }
-- 		buf_set_keymap("n", "<leader>f", ":lua vim.lsp.buf.format { async = true }<CR>", opts)
-- 	end,
--
-- 	settings = {
-- 		["rust-analyzer"] = {
-- 			checkOnSave = {
-- 				command = "clippy",
-- 			},
-- 		},
-- 	},
-- })

local util = require("lspconfig/util")

vim.lsp.config("pyright", {
	settings = {
		python = {
			analysis = {
				-- extraPaths = { "./lib", "./src" }, -- Add directories containing your modules
				useLibraryCodeForTypes = true, -- Ensure library code is used for type checking
			},
		},
		pyright = {
			plugins = {
				-- formatter options
				black = { enabled = false },
				autopep8 = { enabled = true },
				yapf = { enabled = false },
				-- linter options
				pylint = { enabled = true, executable = "pylint" },
				pyflakes = { enabled = false },
				pycodestyle = { enabled = false },
				-- type checker
				pylsp_mypy = { enabled = true },
				-- auto-completion options
				jedi_completion = { fuzzy = true },
				-- import sorting
				pyls_isort = { enabled = true },
			},
		},
	},
	flags = {
		debounce_text_changes = 200,
	},
	capabilities = capabilities,
})
vim.lsp.enable({ "pyright" })

-- vim.lsp.config.pyright.setup({
-- 	root_dir = function(fname)
-- 		-- Always return the top-level directory of your project
-- 		return util.find_git_ancestor(fname)
-- 			or util.root_pattern("pyproject.toml", "setup.py", "requirements.txt", ".git")(fname)
-- 			or vim.loop.cwd()
-- 	end,
-- 	settings = {
-- 		python = {
-- 			analysis = {
-- 				-- extraPaths = { "./lib", "./src" }, -- Add directories containing your modules
-- 				useLibraryCodeForTypes = true, -- Ensure library code is used for type checking
-- 			},
-- 		},
-- 		pyright = {
-- 			plugins = {
-- 				-- formatter options
-- 				black = { enabled = false },
-- 				autopep8 = { enabled = true },
-- 				yapf = { enabled = false },
-- 				-- linter options
-- 				pylint = { enabled = true, executable = "pylint" },
-- 				pyflakes = { enabled = false },
-- 				pycodestyle = { enabled = false },
-- 				-- type checker
-- 				pylsp_mypy = { enabled = true },
-- 				-- auto-completion options
-- 				jedi_completion = { fuzzy = true },
-- 				-- import sorting
-- 				pyls_isort = { enabled = true },
-- 			},
-- 		},
-- 	},
-- 	flags = {
-- 		debounce_text_changes = 200,
-- 	},
-- 	capabilities = capabilities,
-- })

-- lspconfig.jdtls.setup({
-- 	cmd = {
-- 		"/home/ash/.local/share/nvim/mason/bin/jdtls", -- Path to the jdtls executable
-- 		"-configuration",
-- 		"/home/ash/.cache/jdtls/config", -- Path to jdtls config
-- 		"-data",
-- 		"/home/ash/.cache/jdtls/workspace", -- Path to workspace
-- 	},
-- 	settings = {
-- 		java = {
-- 			-- saveActions = {
-- 			-- 	organizeImports = false, -- Disable organizing imports on save
-- 			-- },
-- 			-- diagnostics = {
-- 			-- 	unusedImports = "ignore", -- Ignore unused imports
-- 			-- },
-- 			-- Additional settings can be added here
-- 		},
-- 	},
-- 	on_attach = function(client, bufnr)
-- 		-- Additional customization for `jdtls` if necessary
-- 	end,
-- })

-- lspconfig.lua_ls.setup({})

-- require("lspconfig").lua_ls.setup({
-- 	settings = {
-- 		Lua = {
-- 			runtime = {
-- 				-- Use LuaJIT in Neovim
-- 				version = "LuaJIT",
-- 				path = vim.split(package.path, ";"),
-- 			},
-- 			diagnostics = {
-- 				-- Recognize `vim` global
-- 				globals = { "vim" },
-- 			},
-- 			workspace = {
-- 				-- Add Neovim runtime files as a library
-- 				library = vim.api.nvim_get_runtime_file("", true),
-- 				checkThirdParty = false, -- Optional: avoid prompts about 3rd-party libraries
-- 			},
-- 			telemetry = {
-- 				enable = false, -- Disable telemetry for privacy
-- 			},
-- 			completion = {
-- 				-- Ensure signature help is enabled for Lua
-- 				enable = true,
-- 			},
-- 		},
-- 	},
-- })
-- TODO: change everywhere with the right syntax
-- vim.lsp.config.lua_ls.setup({
-- 	cmd = { "lua-language-server" },
-- 	settings = {
-- 		Lua = {
-- 			runtime = { version = "LuaJIT" },
-- 			diagnostics = { globals = { "vim" } },
-- 			workspace = {
-- 				library = vim.api.nvim_get_runtime_file("", true), -- <—
-- 				checkThirdParty = false,
-- 			},
-- 		},
-- 	},
-- })

-- vim.lsp.config.biome.setup({})
-- vim.lsp.config.eslint.setup({})

-- require("lspconfig").lua_ls.setup({
-- 	on_init = function(client)
-- 		if client.workspace_folders then
-- 			local path = client.workspace_folders[1].name
-- 			if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
-- 				return
-- 			end
-- 		end
--
-- 		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
-- 			runtime = {
-- 				-- Tell the language server which version of Lua you're using
-- 				-- (most likely LuaJIT in the case of Neovim)
-- 				version = "LuaJIT",
-- 			},
-- 			-- Make the server aware of Neovim runtime files
-- 			workspace = {
-- 				checkThirdParty = false,
-- 				library = {
-- 					vim.env.VIMRUNTIME,
-- 					-- Depending on the usage, you might want to add additional paths here.
-- 					-- "${3rd}/luv/library"
-- 					-- "${3rd}/busted/library",
-- 				},
-- 				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
-- 				-- library = vim.api.nvim_get_runtime_file("", true)
-- 			},
-- 		})
-- 	end,
-- 	settings = {
-- 		Lua = {},
-- 	},
-- })
--
-- lspconfig.texlab.setup({})
-- lspconfig.clangd.setup({
-- 	cmd = {
-- 		"clangd",
-- 		"--fallback-style=webkit",
-- 	},
-- })
-- lspconfig.cssls.setup({})
-- lspconfig.eslint.setup({})
-- lspconfig.ts_ls.setup({})
-- -- lspconfig.solc.setup({})
-- lspconfig.html.setup({})
-- lspconfig.eslint.setup({})
-- -- lspconfig.omnisharp_extended.setup({})
--
-- local pid = vim.fn.getpid()
-- local omnisharp_bin = vim.fn.stdpath("data") .. "/mason/packages/omnisharp/omnisharp"
--
-- local util = require("lspconfig/util")
-- -- local omnisharp_ext = require("omnisharp_extended")
-- lspconfig.omnisharp.setup({
-- 	cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
-- 	root_dir = util.root_pattern("*.sln", "*.csproj", ".git"),
-- 	enable_roslyn_analyzers = true,
-- 	organize_imports_on_format = true,
-- 	enable_import_completion = true,
-- 	-- handlers = {
-- 	-- 	["textDocument/definition"] = require("omnisharp_extended").definition_handler,
-- 	-- 	["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
-- 	-- 	["textDocument/references"] = require("omnisharp_extended").references_handler,
-- 	-- 	["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
-- 	-- },
-- })
--
-- require("lspconfig").cssls.setup({
-- 	cmd = { "~/.local/share/nvim/mason/bin/vscode-css-language-server", "--stdio" }, -- Ensure you include '--stdio'
--
-- 	on_attach = function(_, bufnr)
-- 		local function buf_set_keymap(...)
-- 			vim.api.nvim_buf_set_keymap(bufnr, ...)
-- 		end
-- 		local opts = { noremap = true, silent = true }
-- 		buf_set_keymap("n", "<leader>f", ":lua vim.lsp.buf.format { async = true }<CR>", opts)
-- 	end,
--
-- 	settings = {
-- 		css = { validate = true },
-- 		scss = { validate = true },
-- 		less = { validate = true },
-- 	},
-- })
