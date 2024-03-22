
local settings = {
    timeoutlen = 300,
    -- ====================
    -- Editor
    -- ====================

    ----------
    -- Colours
    ----------
    -- True colour support
    termguicolors = true,
    ---------------------
    -- File
    ---------------------
    -- Do not write backups
    backup = false,
    writebackup = false,
    -- Do not create swap files
    swapfile = false,
    -------------------------
    -- Encoding
    -------------------------
    encoding = "utf-8",
    ------------
    -- Clipboard
    ------------
    clipboard = "unnamedplus",
    -----------------------
    -- Format
    -----------------------
    formatoptions = "jcroqlnt",
    ------------------------------
    -- Spellchecking
    ------------------------------
    spelllang = { "en" },
    -- Save undo history
    undofile = true,
    showmode = false,
    ---------------------
    -- UI
    ---------------------
    number = true,
    relativenumber = false,
    scrolloff = 8,
    ruler = true,
    cursorline = true,
    list = true,
    listchars = "trail:·,tab:→ ,nbsp:·",
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    smarttab = true,
    errorbells = false,
    visualbell = false,
    lazyredraw = true,
    synmaxcol = 240,
    updatetime = 50,
    history = 100,
    hidden = true,
    ttyfast = true,
    splitright = true,
    splitbelow = true,
    -- guicursor = "",
    --------
    -- Shell
    --------
    -- For fish users out there, its quite slow compared to stock bash, as such
    -- tell Neovim to use bash to execute commands
    shell = "/bin/zsh",
    -----------
    -- Commands
    -----------
    inccommand = "nosplit",
    smartindent = true,

    incsearch = true,
    hlsearch = true,
    showmatch = true,
    ignorecase = true,
    smartcase = true,
    mouse = 'a',
    completeopt = 'menu,menuone,noselect',
    fillchars = { eob = " ", fold = " " },

    foldmethod = "indent",
    foldenable = false,
    foldlevel = 99
}
for k, v in pairs(settings) do
    vim.opt[k] = v
end

local globals = {
    -- Opt-in to filetype.lua
    -- https://www.reddit.com/r/neovim/comments/rvwsl3/introducing_filetypelua_and_a_call_for_help/
    do_filetype_lua = true,
    did_load_filetypes = true,
    blamer_enabled = true,
    rainbow_active = true,
}

for k, v in pairs(globals) do
    vim.g[k] = v
end

local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
    "tutor",
    "rplugin",
    "synmenu",
    "optwin",
    "compiler",
    "bugreport",
    "ftplugin",
}

for _, v in pairs(disabled_built_ins) do
    vim.g["loaded_" .. v] = 1
end

--- Autogroups and autocommands
--------------------------------
--
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- autoformat on save
vim.api.nvim_create_augroup('AutoFormatting', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'AutoFormatting',
  pattern = { '*.ex,*.exs,*.heex,*.go,*.rs,*.c,*.h' },
  callback = function()
    vim.lsp.buf.format { async = false }
  end
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Configuration for diagnostics
local signs = {
  { name = 'DiagnosticSignError', text = '' },
  { name = 'DiagnosticSignWarn', text = '' },
  { name = 'DiagnosticSignHint', text = '' },
  { name = 'DiagnosticSignInfo', text = '' },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

local config = {
  signs = {
    active = signs, -- show signs
  },
  virtual_text = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = 'minimal',
    border = 'single',
    source = 'always',
    header = 'Diagnostic',
    prefix = '',
  },
}

vim.diagnostic.config(config)

-- Function to check if a floating dialog exists and if not
-- then check for diagnostics under the cursor
function OpenDiagnosticIfNoFloat()
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(winid).zindex then
      return
    end
  end
  -- THIS IS FOR BUILTIN LSP
  vim.diagnostic.open_float(0, {
    scope = "cursor",
    focusable = false,
    close_events = {
      "CursorMoved",
      "CursorMovedI",
      "BufHidden",
      "InsertCharPre",
      "WinLeave",
    },
  })
end

-- Show diagnostics under the cursor when holding position
vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  pattern = "*",
  command = "lua OpenDiagnosticIfNoFloat()",
  group = "lsp_diagnostics_hold",
})

vim.api.nvim_create_user_command("RestNvim", require("rest-nvim").run, {})
