local builtin = require('telescope.builtin')
vim.keymap.set("n", "<leader>f", builtin.find_files, { silent = true, noremap = true })
vim.keymap.set("n", "<C-p>", builtin.git_files, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>g", builtin.live_grep, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>b", builtin.buffers, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>h", builtin.help_tags, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>v", builtin.diagnostics, { silent = true, noremap = true })

