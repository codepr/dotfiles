local remap = vim.keymap.set
require('config.autotest')

-- Remap for dealing with word wrap
remap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
remap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
remap("v", "J", ":m '>+1<CR>gv=gv")
remap("v", "K", ":m '<-2<CR>gv=gv")
remap("n", "<C-d>", "<C-d>zz")
remap("n", "<C-u>", "<C-u>zz")
remap("n", "Q", "<nop>")
remap("n", "0", "^", { silent = true, noremap = true })
remap("n", "<TAB>", ":bnext<CR>", { silent = true, noremap = true })
remap("n", "<S-TAB>", ":bprev<CR>", { silent = true, noremap = true })
remap("i", "jk", "<ESC>", { silent = true, noremap = true })
remap("i", "kj", "<ESC>", { silent = true, noremap = true })
remap("n", "<leader>,", ":noh<CR>", { silent = true, noremap = true })
remap("n", "<C-j>", "<C-w><C-j>", { silent = true, noremap = true })
remap("n", "<C-k>", "<C-w><C-k>", { silent = true, noremap = true })
remap("n", "<C-l>", "<C-w><C-l>", { silent = true, noremap = true })
remap("n", "<C-h>", "<C-w><C-h>", { silent = true, noremap = true })
remap("n", "*", "*zz", { silent = true, noremap = true })
remap("n", "n", "nzz", { silent = true, noremap = true })
remap("n", "N", "Nzz", { silent = true, noremap = true })
remap("v", "<", "<gv", { silent = true, noremap = true })
remap("v", ">", ">gv", { silent = true, noremap = true })
remap("n", "<leader>d", ":bp<bar>sp<bar>bn<bar>bd<cr>", { silent = true, noremap = true })
remap("n", "<C-\\>", ":ToggleTerm<CR>", { silent = true, noremap = true })
remap("n", "<leader>e", ":e %:p:h/", { silent = true, noremap = true })
remap("n", "<esc>", ":noh<return><esc>", { silent = true, noremap = true })
remap("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = 'Rename the word across the buffer' })
remap("n", "<leader>t", ":NvimTreeFindFileToggle<CR>", { desc = 'Toggle Tree find file' })
remap("n", "<leader>a", ":AerialToggle<CR>", { desc = 'Toggle Aerial' })
-- Diagnostic keymaps
remap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
remap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
remap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
-- Custom
remap('n', "<leader>.", ":lua run_test_at_cursor()<cr><cr>", { silent = true, noremap = true })

local goto = require("goto-preview")

remap('n', 'gpd', goto.goto_preview_definition, { desc = 'Go to definition with preview' })
remap('n', 'gpt', goto.goto_preview_type_definition)
remap('n', 'gpi', goto.goto_preview_implementation)
remap('n', 'gpD', goto.goto_preview_declaration)
remap('n', 'gP', goto.close_all_win)
remap('n', 'gpr', goto.goto_preview_references)

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
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = "term://*",
  command = "lua set_terminal_keymaps()",
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*",
  command = "set noro",
})
