vim.cmd([[
call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
" or                                , { 'branch': '0.1.x' }
"Plug 'epwalsh/obsidian.nvim', {'tag': 'v3.9.0'}
Plug 'folke/todo-comments.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'

Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'ap/vim-css-color'
Plug 'stevearc/oil.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'lervag/vimtex'
Plug 'ggandor/leap.nvim'
Plug 'stevearc/conform.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'catppuccin/nvim'
"Plug 'mfussenegger/nvim-jdtls'
Plug 'github/copilot.vim'
"Plug 'zbirenbaum/copilot.lua'
Plug 'EdenEast/nightfox.nvim'
Plug 'stevearc/aerial.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug '3rd/image.nvim'
Plug 'sindrets/diffview.nvim'
"Plug 'MeanderingProgrammer/render-markdown.nvim'
"Plug 'folke/noice.nvim'
"Plug 'MunifTanjim/nui.nvim'
"Plug 'rcarriga/nvim-notify'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'tyru/open-browser.vim'
Plug 'aklt/plantuml-syntax'

Plug 'lewis6991/gitsigns.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

"Plug '$HOME/example.nvim'
Plug 'NeogitOrg/neogit'
Plug 'chomosuke/typst-preview.nvim', {'tag': 'v1.*'}
Plug 'wannesm/wmgraphviz.vim'
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'
Plug 'Hoffs/omnisharp-extended-lsp.nvim'
Plug 'folke/trouble.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'
Plug 'CopilotC-Nvim/CopilotChat.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'
Plug 'xiyaowong/transparent.nvim' 
Plug 'ibhagwan/fzf-lua'
Plug 'chomosuke/typst-preview.nvim'
Plug 'mbbill/undotree'
Plug 'ThePrimeagen/harpoon', {'branch': 'harpoon2'}

"TODO: add vim table mode


call plug#end()
]])
