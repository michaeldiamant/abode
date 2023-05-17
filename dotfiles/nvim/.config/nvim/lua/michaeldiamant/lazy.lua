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

require("lazy").setup({
  -- Prerequisites
  "nvim-lua/plenary.nvim",
  "windwp/nvim-autopairs", -- add parentheses on autocomplete

  -- Color schemes
  { "rose-pine/neovim", name = "rose-pine" },

  -- cmp
  "hrsh7th/nvim-cmp", -- The completion plugin
  "hrsh7th/cmp-buffer", -- buffer completions
  "hrsh7th/cmp-path", -- path completions
  "hrsh7th/cmp-cmdline", -- cmdline completions
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",

  -- Snippets
  "L3MON4D3/LuaSnip", --snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -- LSP
  "neovim/nvim-lspconfig", -- enable LSP
  "williamboman/nvim-lsp-installer", -- simple to use language server installer
  "tamago324/nlsp-settings.nvim", -- language server settings defined in json for
  { "williamboman/mason.nvim", build = ":MasonUpdate" }, -- :MasonUpdate updates registry contents
  "williamboman/mason-lspconfig.nvim",
  "mfussenegger/nvim-jdtls",
  "weilbith/nvim-code-action-menu",
  "simrat39/symbols-outline.nvim",

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "HiPhish/nvim-ts-rainbow2", -- Color corresponding parentheses
  "nvim-treesitter/playground", -- View treesitter info directly in nvim
  "nvim-treesitter/nvim-treesitter-context", -- Shows the current function/class as float window at the top of the window

  -- Telescope
  "nvim-telescope/telescope.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  "smartpde/telescope-recent-files",

  -- Sessions
  "tpope/vim-obsession",
  { "dhruvasagar/vim-prosession", dependencies = { "tpope/vim-obsession" }},

  -- Testing
  "vim-test/vim-test",
  "tpope/vim-dispatch",
  "JalaiAmitahl/maven-compiler.vim", -- Works for compile errors but not tests

  -- Misc
  "tpope/vim-commentary", -- Comment with gc
  "tpope/vim-sleuth", -- Dynamically adjust shiftwidth
  "folke/neodev.nvim", -- Fix undefined global vim errors
  "christoomey/vim-tmux-navigator",
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons"}},

  -- git
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "lewis6991/gitsigns.nvim",
--  "folke/trouble.nvim",
--  "folke/zen-mode.nvim",
--  "github/copilot.vim",
--  "mbbill/undotree",
--  "theprimeagen/harpoon",
--  "theprimeagen/refactoring.nvim",
})

