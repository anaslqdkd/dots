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
})
