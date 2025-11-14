local lsp = require("lsp-zero")
lsp.preset("lsp-compe")

lsp.setup()

vim.opt.completeopt = { "menu", "menuone", "noselect" }

local cmp = require("cmp")
local cmp_config = lsp.defaults.cmp_config({})

cmp.setup(cmp_config)

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

vim.lsp.config("ts_ls", {
	on_attach = function(_, _) end,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	settings = {
		typescript = { format = { enable = true } },
		javascript = { format = { enable = true } },
	},
	filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
	root_dir = vim.fn.getcwd(),
})
vim.lsp.enable({ "ts_ls" })

vim.lsp.config("pyright", {
	settings = {
		python = {
			analysis = {
				useLibraryCodeForTypes = true,
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
