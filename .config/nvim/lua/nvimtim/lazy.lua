local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	"projekt0n/github-nvim-theme",
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/playground",
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
	},
	"mbbill/undotree",
	"folke/trouble.nvim",
	--LuaLine
	"nvim-tree/nvim-web-devicons",
	"nvim-lualine/lualine.nvim",
	--LSP
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"folke/neodev.nvim",
	"neovim/nvim-lspconfig",
	--CMP
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp",
	"saadparwaiz1/cmp_luasnip",
	--Snippets
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",
	--Git
	"lewis6991/gitsigns.nvim",
	"tpope/vim-fugitive",
	--Formatter
	"stevearc/conform.nvim",
	--Lint
	"mfussenegger/nvim-lint",
	--DAP
	"mfussenegger/nvim-dap",
	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = {
			handlers = {},
		},
	},
	"rcarriga/nvim-dap-ui",
	"mfussenegger/nvim-dap-python",
	--TMUX
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	--Copilot
	"github/copilot.vim",
	--Markdown && Jupyter NoteBook
	--BQF
	"kevinhwang91/nvim-bqf",
}
require("lazy").setup(plugins, opts)
