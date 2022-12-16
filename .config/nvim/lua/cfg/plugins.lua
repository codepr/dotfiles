-- ensure the plugin manager is installed
ensure("wbthomason", "packer.nvim")

require('packer').startup(function(use)
  -- install all the plugins you need here

  -- the plugin manager can manage itself
  use {'wbthomason/packer.nvim'}

  -- lsp config for elixir-ls support
  use {'neovim/nvim-lspconfig'}

  -- cmp framework for auto-completion support
  use {'hrsh7th/nvim-cmp'}

  -- cursor jump
  use { 'DanilaMihailov/beacon.nvim' }

  -- install different completion source
  use {'hrsh7th/cmp-nvim-lsp'}
  use {'hrsh7th/cmp-buffer'}
  use {'hrsh7th/cmp-path'}
  use {'hrsh7th/cmp-cmdline'}

  -- you need a snippet engine for snippet support
  -- here I'm using vsnip which can load snippets in vscode format
  use {'hrsh7th/vim-vsnip'}
  use {'hrsh7th/cmp-vsnip'}

  -- treesitter for syntax highlighting and more
  use {'nvim-treesitter/nvim-treesitter'}
  use {'sheerun/vim-polyglot'}

  -- colorscheme
  use {'projekt0n/github-nvim-theme'}
  use "EdenEast/nightfox.nvim"
  use 'folke/tokyonight.nvim'

  -- utility
  use "lukas-reineke/indent-blankline.nvim"
  use ({
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "jfpedroza/neotest-elixir",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-elixir"),
            }
        })
    end
    })
  use {'mhinz/vim-grepper'}
  use {'andymass/vim-matchup'}
  use {'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true }}
  use {'ryanoasis/vim-devicons'}
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  use {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require'hop'.setup {}
    end
  }
  use {'machakann/vim-highlightedyank'}
  use {'nvim-lua/plenary.nvim'}
  use {'nvim-telescope/telescope.nvim'}
  use {'APZelos/blamer.nvim'}
  use {'lewis6991/gitsigns.nvim'}
  use { 'tpope/vim-fugitive' }                       -- git integration
  use { 'tpope/vim-commentary' }
  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup()
  end}
  use {
  "folke/trouble.nvim",
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
    require("trouble").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
}

use {'jose-elias-alvarez/null-ls.nvim'}

end)
