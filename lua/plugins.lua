return require('packer').startup(function (use)
  -- Package Manager for nvim
  use "wbthomason/packer.nvim"
  
  use "EdenEast/nightfox.nvim"
  
  use "nvim-tree/nvim-web-devicons"

  use "folke/tokyonight.nvim"

  use "preservim/tagbar"
		
		use "daschw/leaf.nvim"

  use "catppuccin/nvim"
  use "ribru17/bamboo.nvim"
  use "savq/melange-nvim"
  use "NLKNguyen/papercolor-theme"
  use "rebelot/kanagawa.nvim"

  use "KeitaNakamura/neodark.vim"
  use "sbdchd/neoformat"
  use 'navarasu/onedark.nvim'
  -- use lazygit
  use({
      "kdheepak/lazygit.nvim",
      -- optional for floating window border decoration
      requires = {
          "nvim-lua/plenary.nvim",
      },
  })

  use "sisrfeng/git-vim_lens"

  use { "ellisonleao/gruvbox.nvim" }
  
  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    }
  }

  use "ray-x/lsp_signature.nvim"

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' }
  }

  use "folke/which-key.nvim"


use { -- for autocomplete and language support
"VonHeikemen/lsp-zero.nvim",
branch = "v2.x",
requires = {
        -- LSP Support
        {"neovim/nvim-lspconfig"}, -- Required
        -- Autocompletion
    {"hrsh7th/nvim-cmp"}, -- Required
        {"hrsh7th/cmp-nvim-lsp"}, -- Required
        {"L3MON4D3/LuaSnip"} -- Required
    }  }



  -- Bottom status bar
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  };
  -- Pairs for ( {  [, basically all that requires closing
  use "jiangmiao/auto-pairs"

  -- Nvim Themes 
  use "wadackel/vim-dogrun"
  use "sainnhe/everforest"

  -- Terminal
  use 'voldikss/vim-floaterm'

  -- For Start screen
  use 'mhinz/vim-startify'

  -- For file explorer
   use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    }
  }
  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  }

  -- For git functions
  use {'lewis6991/gitsigns.nvim'}

		use{ 'anuvyklack/pretty-fold.nvim',
		config = function()
			require('pretty-fold').setup()
		end
	}

  -- For angular component switch 
  use { 'joeveiga/ng.nvim'}

  -- For backlines
  -- use "lukas-reineke/indent-blankline.nvim"

  -- For notifications
  use 'rcarriga/nvim-notify'


end)
