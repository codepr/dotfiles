-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Match parens effectively
  'andymass/vim-matchup',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  { "preservim/vim-markdown" },

  { -- signature hints
      "ray-x/lsp_signature.nvim",
      -- loading on `require` or InsertEnter ignores the config, so loading on LspAttach
      event = "LspAttach",
      opts = {
          floating_window = false,
          hint_prefix = "󰘎 ",
          hint_scheme = "NonText", -- = highlight group
      },
      config = function(_, opts) require'lsp_signature'.setup(opts) end
  },

  { -- display inlay hints from LSP
      "lvimuser/lsp-inlayhints.nvim", -- INFO only temporarily needed, until https://github.com/neovim/neovim/issues/18086
      init = function()
          if vim.version().major == 0 and vim.version().minor >= 10 then
              vim.notify("lsp-inlayhints.nvim is now obsolete.")
          end

          vim.api.nvim_create_autocmd("LspAttach", {
              callback = function(args)
                  local bufnr = args.buf
                  local client = vim.lsp.get_client_by_id(args.data.client_id)
                  local capabilities = client.server_capabilities
                  if capabilities.inlayHintProvider then
                      require("lsp-inlayhints").on_attach(client, bufnr, false)
                  end
              end,
          })
      end,
      opts = {
          inlay_hints = {
              parameter_hints = {
                  prefix = " ",
                  remove_colon_start = true,
                  remove_colon_end = true,
              },
              type_hints = {
                  prefix = " ",
                  remove_colon_start = true,
                  remove_colon_end = true,
              },
              labels_separator = ":",
              only_current_line = true,
              highlight = "NonText",
          },
      },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
	event = { "InsertEnter", "CmdlineEnter" }, -- CmdlineEnter for completions there
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',

      -- Buffer completion
      'hrsh7th/cmp-buffer',

      -- FS path completion
      'hrsh7th/cmp-path',

      -- Command line completion
      'hrsh7th/cmp-cmdline',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', event = "VeryLazy", opts = {} },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = "VeryLazy",
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'catpuccin',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require("nvim-tree").setup()
    end
  },

  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require('aerial').setup({
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
          vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
        end
      })
      -- You probably also want to set a keymap to toggle aerial
      vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')
    end
  },

  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    config = function(_, opts)
      require('rust-tools').setup(opts)
    end
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      function ColorMe(color, transparency)
          color = color or "catppuccin"
          require("catppuccin").setup({
              flavour = "mocha", -- latte, frappe, macchiato, mocha
              background = { -- :h background
                  light = "latte",
                  dark = "mocha",
              },
              transparent_background = false, -- disables setting the background color.
              show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
              term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
              dim_inactive = {
                  enabled = false, -- dims the background color of inactive window
                  shade = "dark",
                  percentage = 0.15, -- percentage of the shade to apply to the inactive window
              },
              no_italic = false, -- Force no italic
              no_bold = false, -- Force no bold
              no_underline = false, -- Force no underline
              styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
                  comments = { "italic" }, -- Change the style of comments
                  conditionals = { "italic" },
                  loops = {},
                  functions = {},
                  keywords = {},
                  strings = {},
                  variables = {},
                  numbers = {},
                  booleans = {},
                  properties = {},
                  types = {},
                  operators = {},
              },
              color_overrides = {},
              custom_highlights = {},
              integrations = {
                  cmp = true,
                  gitsigns = true,
                  nvimtree = true,
                  treesitter = true,
                  notify = false,
                  mini = {
                      enabled = true,
                      indentscope_color = "",
                  },
              },
          })
          vim.cmd.colorscheme(color)
          if transparency then
            vim.api.nvim_set_hl(0, "Normal", { bg = "black" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#202020" })
            vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#e86671", bg = "none" })
            vim.cmd 'highlight TelescopeBorder guibg=none'
            vim.cmd 'highlight TelescopeTitle guibg=none'
            vim.cmd 'highlight TelescopePromptNormal guibg=none'
            vim.cmd 'highlight TelescopeResultsNormal guibg=none'
            vim.cmd 'highlight TelescopePreviewNormal guibg=none'
            vim.cmd 'highlight NvimTreeNormal guibg=none'
            vim.cmd 'highlight NvimTreeNormalNC guibg=none'
          end
      end

      ColorMe('catppuccin', false)
    end,

  },

  {'akinsho/toggleterm.nvim', version = "*", config = true}
  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
}, {})
