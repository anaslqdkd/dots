-- Automatically start Markdown preview when opening a markdown file (0 = disabled, 1 = enabled)
vim.g.mkdp_auto_start = 0

-- Automatically close the preview when switching to another buffer (0 = disabled, 1 = enabled)
vim.g.mkdp_auto_close = 1

-- Slow refresh mode (0 = normal, 1 = slow mode)
vim.g.mkdp_refresh_slow = 0

-- Enable global `:MarkdownPreview` command (0 = only for markdown files, 1 = always available)
vim.g.mkdp_command_for_global = 0

-- Open preview to the local network (0 = only localhost, 1 = allow external access)
vim.g.mkdp_open_to_the_world = 0

-- IP address to use for opening the preview (empty means default localhost)
vim.g.mkdp_open_ip = ""

-- Preferred browser for the preview (empty = default system browser)
vim.g.mkdp_browser = ""

-- Echo preview URL in the command line when opening (0 = disabled, 1 = enabled)
vim.g.mkdp_echo_preview_url = 0

-- Custom function to open the browser (empty = default behavior)
vim.g.mkdp_browserfunc = ""

-- Options for customizing the preview
vim.g.mkdp_preview_options = {
	mkit = {}, -- Options for markdown-it parser
	katex = {}, -- Options for KaTeX math rendering
	uml = {}, -- Options for UML diagrams
	maid = {}, -- Options for Mermaid diagrams
	disable_sync_scroll = 0, -- Disable synchronized scrolling (0 = enabled, 1 = disabled)
	sync_scroll_type = "middle", -- Scroll type ('middle', 'top', 'relative')
	hide_yaml_meta = 1, -- Hide YAML metadata at the top of Markdown files (0 = show, 1 = hide)
	sequence_diagrams = {}, -- Options for sequence diagrams
	flowchart_diagrams = {}, -- Options for flowchart diagrams
	content_editable = false, -- Enable editing directly in the preview (false = disabled)
	disable_filename = 0, -- Hide the filename in the preview (0 = show, 1 = hide)
	toc = {}, -- Options for the Table of Contents
}

-- Custom CSS file for Markdown rendering (empty = default styling)
vim.g.mkdp_markdown_css = ""

-- Custom CSS file for syntax highlighting (empty = default highlighting)
vim.g.mkdp_highlight_css = ""

-- Port number for the preview server (empty = use a random available port)
vim.g.mkdp_port = ""

-- Page title template (e.g., filename in preview title)
vim.g.mkdp_page_title = "「${name}」"

-- Path where images inserted in markdown are stored (e.g., screenshots)
vim.g.mkdp_images_path = "~/.markdown_images"

-- List of file types where the preview should be available
vim.g.mkdp_filetypes = { "markdown" }

-- Set the preview theme ('light' or 'dark')
vim.g.mkdp_theme = "dark"

--[[
-- Combine multiple markdown files into one preview (0 = disabled, 1 = enabled)
vim.g.mkdp_combine_preview = 0

-- Automatically refresh combined preview when a file changes (0 = disabled, 1 = enabled)
vim.g.mkdp_combine_preview_auto_refresh = 1
--]]
