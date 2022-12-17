require("mason").setup()
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
    use_treesitter = true,
    buftype_exclude = {
        'terminal',
        'nofile',
        'quickfix',
        'prompt',
    },
    filetype_exclude = {
        'lspinfo',
        'packer',
        'checkhealth',
        'help',
        'man',
        'dashboard',
        'git',
        'markdown',
        'text',
        'terminal',
        'NvimTree',
    }
}

require("nvim-tree").setup()
vim.api.nvim_set_keymap("n", "<leader>t", ":NvimTreeFindFile<cr>", { silent = true, noremap = true })

function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', 'kj', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
vim.cmd('autocmd! FileType elixir setlocal commentstring=#\\ %s')


-- local has_null_ls, null_ls = pcall(require, "null-ls")
-- if not has_null_ls then
-- 	return
-- end

-- null_ls.setup({
-- 	sources = {
-- 		-- Diagnostics
-- 		null_ls.builtins.diagnostics.credo,
-- 		-- Code actions
-- 		null_ls.builtins.code_actions.gitsigns,
-- 		-- Formatters
-- 		null_ls.builtins.formatting.mix,
-- 	},
-- })

vim.api.nvim_command("au BufRead,BufNewFile *.ex,*.exs set filetype=elixir")
vim.api.nvim_command("au BufRead,BufNewFile *.eex,*.heex,*.leex,*.sface,*.lexs set filetype=eelixir")
vim.api.nvim_command("au BufRead,BufNewFile mix.lock set filetype=elixir")
vim.api.nvim_command("au BufWinEnter *.<fileextension> set updatetime=300 | set ft=<filetype>| set autoread ")
vim.api.nvim_command("au CursorHold *.<fileextension>  checktime")
vim.api.nvim_command("au BufWritePost *.lua lua vim.lsp.buf.format({ async = true })")
vim.api.nvim_command("au BufWritePost *.ex lua vim.lsp.buf.format({ timeout_ms = 2000 })")
vim.api.nvim_command("au BufWritePost *.exs lua vim.lsp.buf.format({ timeout_ms = 2000 })")
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

local function ends_with(str, ending)
    return ending == "" or str:sub(- #ending) == ending
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

vim.api.nvim_set_keymap('n', '<leader>T', ':lua jump_to_test()<CR>', { noremap = true })
