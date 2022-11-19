local execute = vim.api.nvim_command
local fn = vim.fn local fmt = string.format

local pack_path = fn.stdpath("data") .. "/site/pack"

-- ensure a given plugin from github.com/<user>/<repo> is cloned in the pack/packer/start directory
local function ensure (user, repo)
  local install_path = fmt("%s/packer/start/%s", pack_path, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path))
    execute(fmt("packadd %s", repo))
  end
end

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
  use "mickael-menu/zk-nvim"
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
  -- use {'scrooloose/nerdtree'}
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

-- `on_attach` callback will be called after a language server
-- instance has been attached to an open buffer with matching filetype
-- here we're setting key mappings for hover documentation, goto definitions, goto references, etc
-- you may set those key mappings based on your own preference
local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true }

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}

require('lspconfig').elixirls.setup {
  cmd = { "elixir-ls" },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false
    }
  }
}

require('lspconfig').efm.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {"elixir"}
})

local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      -- setting up snippet engine
      -- this is for vsnip, if you're using other
      -- snippet engine, please refer to the `nvim-cmp` guide
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    { name = 'buffer' }
  })
})

-- helper functions
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
  -- other settings ...
  mapping = {
    -- other mappings ...
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
	cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
	feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
	cmp.complete()
      else
	fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
	cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
	feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" })
  }
})

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "elixir", "eex", "erlang", "heex", "html", "surface" },
  sync_install = false,
  ignore_install = { },
  highlight = {
    enable = true,
    disable = { },
    additional_vim_regex_highlighting = false,
  },
  matchup = {
      enable = true
  }
}

require("zk").setup({
  picker = "telescope",

  lsp = {
    -- `config` is passed to `vim.lsp.start_client(config)`
    config = {
      cmd = { "zk", "lsp" },
      name = "zk",
      -- on_attach = ...
      -- etc, see `:h vim.lsp.start_client()`
    },

    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
})

require('gitsigns').setup()
require('lualine').setup()

----require("null-ls").setup({
----    sources = {
-------        require("null-ls").builtins.formatting.mix,
----        require("null-ls").builtins.diagnostics.credo,
----        require("null-ls").builtins.code_actions.gitsigns,
----        ----require("null-ls").builtins.completion.spell
----    },
----})

vim.cmd [[
  syntax enable
  colorscheme tokyonight-storm
]]

vim.o.timeoutlen = 300

vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "0", "^", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "j", "gj", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "k", "gk", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<TAB>", ":bnext<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<S-TAB>", ":bprev<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "jk", "<ESC>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "kj", "<ESC>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>,", ":noh<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w><C-j>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w><C-k>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w><C-l>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w><C-h>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "*", "*zz", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "n", "nzz", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "N", "Nzz", { silent = true, noremap = true })
vim.api.nvim_set_keymap("v", "<", "<gv", { silent = true, noremap = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>d", ":bp<bar>sp<bar>bn<bar>bd<cr>", { silent = true, noremap = true })
---vim.api.nvim_set_keymap("n", "?", "?\v", { silent = true, noremap = true })
---vim.api.nvim_set_keymap("n", "/", "/\v", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<C-\\>", ":ToggleTerm<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>e", ":e %:p:h/", { silent = true, noremap = true })

vim.api.nvim_set_keymap("n", "<leader>f", ":Telescope find_files<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>g", ":Telescope live_grep<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>b", ":Telescope buffers<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>h", ":Telescope help_tags<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",
  {silent = true, noremap = true}
)

-- vim.api.nvim_set_keymap("n", "<leader>t", ":NERDTreeFind<cr>", { silent = true, noremap = true })

require("nvim-tree").setup()
vim.api.nvim_set_keymap("n", "<leader>t", ":NvimTreeFindFile<cr>", { silent = true, noremap = true })

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'kj', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
  -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  -- vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  -- vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  -- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
vim.cmd('autocmd! FileType elixir setlocal commentstring=#\\ %s')
-- ====================
-- Editor
-- ====================

----------
-- Colours
----------
-- True colour support
vim.o.termguicolors = true
---------------------
-- File
---------------------
-- Do not write backups
vim.o.backup = false
vim.o.writebackup = false
-- Do not create swap files
vim.o.swapfile = false
-- Opt-in to filetype.lua
-- https://www.reddit.com/r/neovim/comments/rvwsl3/introducing_filetypelua_and_a_call_for_help/
vim.g.do_filetype_lua = true
vim.g.did_load_filetypes = true
-------------------------
-- Encoding
-------------------------
vim.o.encoding = "utf-8"
------------
-- Clipboard
------------
vim.o.clipboard = "unnamed"
-----------------------
-- Format
-----------------------
vim.o.formatoptions = "qj"
------------------------------
-- Spellchecking
------------------------------
vim.o.spelllang = "en"
---------------------
-- UI
---------------------
vim.o.number = true
vim.wo.relativenumber = true
vim.o.scrolloff = 4
vim.o.ruler = true
vim.o.cursorline = true
vim.o.listchars = "trail:·,tab:→ ,nbsp:·"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.errorbells = false
vim.o.visualbell = false
vim.o.lazyredraw = true
vim.o.ttyfast = true
vim.g.rainbow_active = true
vim.o.splitright = true
--------
-- Shell
--------
-- For fish users out there, its quite slow compared to stock bash, as such
-- tell Neovim to use bash to execute commands
vim.opt.shell = "/bin/zsh"
-----------
-- Commands
-----------
vim.o.inccommand = "nosplit"

vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.showmatch = true
vim.cmd([[ set ignorecase ]])
vim.cmd([[ set smartcase ]])
vim.cmd([[ set mouse=a ]])
vim.cmd([[ nnoremap <esc> :noh<return><esc> ]])

vim.g.blamer_enabled = true


local has_null_ls, null_ls = pcall(require, "null-ls")
if not has_null_ls then
	return
end

null_ls.setup({
	sources = {
		-- Diagnostics
		null_ls.builtins.diagnostics.credo,
		-- Code actions
		null_ls.builtins.code_actions.gitsigns,
		-- Formatters
		null_ls.builtins.formatting.mix,
	},
})

vim.api.nvim_command("au BufRead,BufNewFile *.ex,*.exs set filetype=elixir")
vim.api.nvim_command("au BufRead,BufNewFile *.eex,*.heex,*.leex,*.sface,*.lexs set filetype=eelixir")
vim.api.nvim_command("au BufRead,BufNewFile mix.lock set filetype=elixir")
vim.api.nvim_command("au BufWinEnter *.<fileextension> set updatetime=300 | set ft=<filetype>| set autoread ")
vim.api.nvim_command("au CursorHold *.<fileextension>  checktime")
vim.api.nvim_command("au BufWritePost *.lua lua vim.lsp.buf.formatting()")
vim.api.nvim_command("au BufWritePost *.ex lua vim.lsp.buf.formatting_seq_sync()")
vim.api.nvim_command("au BufWritePost *.exs lua vim.lsp.buf.formatting_seq_sync()")
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

local function ends_with(str, ending)
   return ending == "" or str:sub(-#ending) == ending
end

function _G.jump_to_test()
    local current_file = vim.fn.expand('%:t:r')
    if ends_with(current_file, "_test") then
        local handle = io.popen("fd " .. current_file:gsub("%_test", ".ex"))
        local result = handle:read("*a")
        handle:close()
        vim.cmd("e " .. result)
    else
        local handle = io.popen("fd " .. vim.fn.expand('%:t:r') .. "_test.exs")
        local result = handle:read("*a")
        handle:close()
        vim.cmd("e " .. result)
    end
end

vim.api.nvim_set_keymap('n', '<leader>T', ':lua jump_to_test()<CR>', {noremap = true})
