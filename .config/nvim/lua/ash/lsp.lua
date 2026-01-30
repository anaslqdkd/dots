vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- local cmp = require("cmp")
-- local cmp_config = lsp.defaults.cmp_config({})

-- cmp.setup(cmp_config)
require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<C-p>"] = { "select_prev", "fallback" },
		["<C-n>"] = { "select_next", "fallback" },
		["<cr>"] = { "accept", "fallback" },
	},
})

local luasnip = require("luasnip")
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- LSP keymaps setup function
local function setup_lsp_keymaps(event)
	local opts = { buffer = event.buf }

	-- Navigation
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

	-- Documentation
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

	-- Code actions
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	-- Formatting
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, opts)

	-- Diagnostics
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

	-- Workspace folders (useful for Rust multi-crate projects)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
end

-- Setup keymaps when LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = setup_lsp_keymaps,
})

-- vim.lsp.config("ts_ls", {
-- 	on_attach = function(_, _) end,
-- 	settings = {
-- 		typescript = { format = { enable = true } },
-- 		javascript = { format = { enable = true } },
-- 	},
-- 	filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
-- 	root_dir = vim.fn.getcwd(),
-- })
-- vim.lsp.enable({ "ts_ls" })

vim.lsp.config("pyright", {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	capabilities = capabilities,
	settings = {
		python = {
			analysis = {
				useLibraryCodeForTypes = true,
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				typeCheckingMode = "basic",
			},
		},
	},
	flags = {
		debounce_text_changes = 200,
	},
})

vim.lsp.config("rust_analyzer", {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
				loadOutDirsFromCheck = true,
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
				attributes = {
					enable = true,
				},
			},
			-- Check on save with clippy
			checkOnSave = true,
			-- Inlay hints
			inlayHints = {
				bindingModeHints = {
					enable = true,
				},
				chainingHints = {
					enable = true,
				},
				closingBraceHints = {
					minLines = 10,
				},
				closureReturnTypeHints = {
					enable = "with_block",
				},
				lifetimeElisionHints = {
					enable = "skip_trivial",
					useParameterNames = true,
				},
				parameterHints = {
					enable = true,
				},
				typeHints = {
					enable = true,
					hideClosureInitialization = false,
					hideNamedConstructor = false,
				},
			},
			-- Diagnostics
			diagnostics = {
				enable = true,
				experimental = {
					enable = true,
				},
			},
			-- Hover actions
			hover = {
				actions = {
					enable = true,
					references = {
						enable = true,
					},
				},
			},
			-- Completion settings
			completion = {
				autoimport = {
					enable = true,
				},
				privateEditable = {
					enable = true,
				},
			},
		},
	},
})
  vim.lsp.config("texlab", {
      cmd = { "texlab" },
      filetypes = { "tex", "plaintex", "bib" },
      root_markers = { ".latexmkrc", ".texlabroot", "texlabroot", "Tectonic.toml", ".git" },
      capabilities = capabilities,
      settings = {
        texlab = {
          build = { onSave = true },
          chktex = {
            onEdit = false,
            onOpenAndSave = false,
          },
          diagnosticsDelay = 300,
        },
      },
    })

vim.lsp.config("tinymist", {
	cmd = { "tinymist" },
	filetypes = { "typst" },
	capabilities = capabilities,
	settings = {
		exportPdf = "onSave",
		formatterMode = "typstyle",
	},
})

vim.lsp.enable({ "pyright" })
vim.lsp.enable({ "rust_analyzer" })
vim.lsp.enable({ "texlab" })
vim.lsp.enable({ "tinymist" })
