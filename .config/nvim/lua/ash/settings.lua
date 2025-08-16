-- vim.cmd("colorscheme nightfox")
vim.opt.guicursor = ""
-- vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20"
vim.opt.guicursor =
	"n-v-c:block-blinkon100-blinkoff100-blinkwait100,i-ci-ve:ver25-blinkon100-blinkoff100-blinkwait100,r-cr-o:hor20"
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.smartindent = true
vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

vim.opt.cursorline = true
vim.opt.foldmethod = "manual"

vim.diagnostic.config({ virtual_text = false })
vim.diagnostic.config({ signs = false })

vim.opt.splitright = true
vim.o.splitbelow = true
vim.opt.autoread = true
vim.opt.conceallevel = 2

vim.o.foldcolumn = "1"
vim.o.foldlevel = 2000
vim.o.foldlevelstart = 200000
vim.o.foldenable = true

vim.opt.viminfo = "'100,f1"

vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = "1"

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<Right>", 'copilot#Accept("<CR>")', {
	expr = true,
	silent = true,
	noremap = true,
	replace_keycodes = false,
})
