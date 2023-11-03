vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	-- gotta load packer
	use("wbthomason/packer.nvim")

	-- plenary provides a collection of util functions/modules that can be used by other nvim plugins
	use("nvim-lua/plenary.nvim")

	-- Kanagawa Colour Scheme Pack
	use("rebelot/kanagawa.nvim")

	-- Gruvbox Colour Scheme Pack
	use("morhetz/gruvbox")

	-- Nightfly Colour Scheme
	use("bluz71/vim-nightfly-colors")

	-- Tokyo Night Theme Pack
	use("folke/tokyonight.nvim")

	-- tmux and split window navigation
	use("christoomey/vim-tmux-navigator")

	-- ability to maximize and restore the current window
	use("szw/vim-maximizer")

	-- provide mappings to easily delete, change, and add such surroundings in pairs
	use("tpope/vim-surround")

	-- smart and powerful commenting plugin for neovim
	use("numToStr/Comment.nvim")

	-- file explorer
	use("nvim-tree/nvim-tree.lua")

	-- cool file icons
	use("nvim-tree/nvim-web-devicons")

	-- statusline
	use("nvim-lualine/lualine.nvim")

	-- telescope (fuzzy finder) sorting algorithm (this is a dependency of the telescope plugin itself)
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.2" })

	-- autocompletion

	-- specific source of completion suggestions that pulls from current and other open buffers (files)
	use({ "hrsh7th/cmp-buffer" })
	-- specific source of completion suggestions that pulls from and provides suggstions based on your filesystem
	use({ "hrsh7th/cmp-path" })
	-- serves as the core engine and backbone for providing completions
	use({ "hrsh7th/nvim-cmp" })

	-- snippets
	use({ "rafamadriz/friendly-snippets" }) -- a collection of pre-made snippets for various languages.
	use({ "saadparwaiz1/cmp_luasnip" }) -- a bridge that lets nvim-cmp understand and offer snippets from luasnip as completion options.
	use({ "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } }) --  core part of snippets. Provides code snippets, like little templates of common code patterns.

	-- LSP Stuff
	--
	-- Step 1. For managing and installing LSP servers
	-- LSP is built into neovim, but the LSP servers themselves have to be installed.
	--
	-- mason.nvim is designed to simplify the setup of Neovim's LSP (language server protocol).
	-- In essence, it provides a streamlined interface for setting up LSP configurations.
	-- It also (down below) is used to manage linters and formatters.
	use("williamboman/mason.nvim")

	-- mason-lspconfig provides ready to use configs for various language servers,
	-- makes setting up LSP in nvim more straightforward and user friendly and
	-- extends the functionality of nvim-lspconfig.
	-- note that the difference between mason-lspconfig and nvim-lspconfig is that
	-- nvim-lspconfig is an official plugin from the nvim team to help configure LSP and
	-- various languages in neovim, and mason-lspconfig offers extended, potentially
	-- optimized configurations on top of that foundation. these optimized configurations
	-- are opinionated from its author.
	use("williamboman/mason-lspconfig.nvim")

	-- Step 2. Install foundation (nvim-lspconfig)
	-- nvim-lspconfig is the foundation for LSP configuration.
	-- it provides default configurations and setup utilities
	-- for a variety of language servers in neovim.
	use("neovim/nvim-lspconfig")

	-- Step 3. This is to enhance the LSP autocomplete experience.
	-- lspsaga.nvim takes the raw, functional features provided by
	-- LSP in Neovim and wraps them in a more attractive and
	-- user-friendly interface.
	use({ "nvimdev/lspsaga.nvim" })

	-- Step 4. Add pictographic icons to Neovim's built in LSP.
	-- It's cool.
	use("onsails/lspkind.nvim")

	-- Step 5. Bridge the gap between nvim-cmp and nvim-lspconfig.
	-- This feeds completion suggestions from the LSP into nvim-cmp.
	use("hrsh7th/cmp-nvim-lsp")

	-- Formatting and Linting

	-- With null-ls, You can use command-line tools (linters, formatters, etc.)
	-- as if they were LSP servers. This means you get to use the same mechanisms
	-- for diagnostics, code actions, and more that the built-in LSP provides,
	-- but for tools that don't natively support LSP.
	--
	-- Overall it allows users to define custom sources to extend the functionality
	-- of Neovim's LSP. These sources can respond to various LSP requests and are
	-- configured using methods and parameters.
	use("jose-elias-alvarez/null-ls.nvim")

	-- mason-null-ls closes some gaps that exist between null-ls and mason.
	use("jay-babu/mason-null-ls.nvim")

	-- nvim treesitter
	-- Tree-sitter and nvim-treesitter elevate Neovim's capabilities in
	-- understanding and working with source code. It offers better syntax
	-- highlighting, more accurate code navigation, and other advanced
	-- features that rely on a deep understanding of code syntax and structure.
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- auto closing
	-- nvim-autopairs provides automatic pairing functionality for
	-- various delimiters such as parentheses, brackets, and quotes.
	use("windwp/nvim-autopairs")

	-- nvim-ts-autotag is specifically for XML/HTML tags. Using the power of
	-- tree-sitter, it automatically updates the closing tag when you modify
	-- the opening tag. For instance, if you have <div>|</div> and you change
	-- div to span, the closing tag will automatically update to </span>.
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })

	-- Gitsigns - shows changed lines, etc.
	use("lewis6991/gitsigns.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
