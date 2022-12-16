vim.cmd [[
    syntax enable
    colorscheme tokyonight-storm
]]

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
    clipboard = "unnamed",
    -----------------------
    -- Format
    -----------------------
    formatoptions = "qj",
    ------------------------------
    -- Spellchecking
    ------------------------------
    spelllang = "en",
    ---------------------
    -- UI
    ---------------------
    number = true,
    relativenumber = true,
    scrolloff = 4,
    ruler = true,
    cursorline = true,
    listchars = "trail:·,tab:→ ,nbsp:·",
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    smarttab = true,
    errorbells = false,
    visualbell = false,
    lazyredraw = true,
    synmaxcol = 240,
    updatetime = 250,
    history = 100,
    hidden = true,
    ttyfast = true,
    splitright = true,
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

    incsearch = true,
    hlsearch = true,
    showmatch = true,
    ignorecase = true,
    smartcase = true,
    mouse = a,
    termguicolors = true,
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
