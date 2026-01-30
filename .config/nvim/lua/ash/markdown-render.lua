vim.api.nvim_set_hl(0, "RenderMarkdownH1", { link = "Identifier" }) -- Big title color
vim.api.nvim_set_hl(0, "RenderMarkdownH2", { link = "Keyword" }) -- Function-like color
vim.api.nvim_set_hl(0, "RenderMarkdownH3", { link = "Constant" }) -- Identifier color
vim.api.nvim_set_hl(0, "RenderMarkdownH4", { link = "String" }) -- String color
vim.api.nvim_set_hl(0, "RenderMarkdownH5", { link = "Type" }) -- Type color
vim.api.nvim_set_hl(0, "RenderMarkdownH6", { link = "Number" })

vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { link = "NONE" })
vim.api.nvim_set_hl(0, "RenderMarkdownCodeLanguage", { link = "NONE" })
vim.api.nvim_set_hl(0, "RenderMarkdownCodeInfo", { bg = "NONE" })

vim.api.nvim_set_hl(0, "RenderMarkdownDash", { link = "Identifier" })

-- TODO: finish this
-- local id = vim.api.nvim_get_hl_by_name("Identifier", true)
-- vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = id.foreground, bold = true })

vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { link = "Identifier", bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { link = "Constant" })
vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { link = "String" })
vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { link = "Type" })
vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { link = "Number" })

require("render-markdown").setup({
	heading = {
		enabled = true,
		render_modes = false,
		atx = true,
		setext = true,
		sign = true,
		icons = { "◆ ", "◇ ", "◆ ", "◇ ", "◆ ", "◇ " },
		position = "overlay",
		signs = {},
		width = "full",
		left_margin = 0,
		left_pad = 0,
		right_pad = 0,
		min_width = 0,
		border = false,
		border_virtual = false,
		border_prefix = false,
		above = "▄",
		below = "▀",
		backgrounds = {},
		foregrounds = {
			"RenderMarkdownH1",
			"RenderMarkdownH2",
			"RenderMarkdownH3",
			"RenderMarkdownH4",
			"RenderMarkdownH5",
			"RenderMarkdownH6",
		},
		custom = {},
	},
	code = {
		disable_background = true,
		conceal_delimiters = false,
		highlight_inline = "RenderMarkdownCodeInline",
		highlight_language = false,
		highlight_border = false,
		inline = true,
	},
	dash = {
		highlight = "RenderMarkdownDash",
	},
	checkbox = {
		-- Checkboxes are a special instance of a 'list_item' that start with a 'shortcut_link'.
		-- There are two special states for unchecked & checked defined in the markdown grammar.

		-- Turn on / off checkbox state rendering.
		enabled = false,
		-- Additional modes to render checkboxes.
		render_modes = false,
		-- Render the bullet point before the checkbox.
		bullet = true,
		-- Padding to add to the left of checkboxes.
		left_pad = 0,
		-- Padding to add to the right of checkboxes.
		right_pad = 1,
		unchecked = {
			-- Replaces '[ ]' of 'task_list_marker_unchecked'.
			icon = '󰄱 ',
			-- Highlight for the unchecked icon.
			highlight = 'RenderMarkdownUnchecked',
			-- Highlight for item associated with unchecked checkbox.
			scope_highlight = nil,
		},
		checked = {
			-- Replaces '[x]' of 'task_list_marker_checked'.
			icon = '󰱒 ',
			-- Highlight for the checked icon.
			highlight = 'RenderMarkdownChecked',
			-- Highlight for item associated with checked checkbox.
			scope_highlight = nil,
		},
		-- Define custom checkbox states, more involved, not part of the markdown grammar.
		-- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks.
		-- The key is for healthcheck and to allow users to change its values, value type below.
		-- | raw             | matched against the raw text of a 'shortcut_link'           |
		-- | rendered        | replaces the 'raw' value when rendering                     |
		-- | highlight       | highlight for the 'rendered' icon                           |
		-- | scope_highlight | optional highlight for item associated with custom checkbox |
		-- stylua: ignore
		custom = {
			todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
		},
		-- Priority to assign to scope highlight.
		scope_priority = nil,
	},
})
