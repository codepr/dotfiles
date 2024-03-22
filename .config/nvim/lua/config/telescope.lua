-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup({
  defaults = {
    path_display = { "shorten" },
    results_title = "",
    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
    layout_strategy = "bottom_pane",
    layout_config = {
      prompt_position = "bottom",
    },
    prompt_prefix = "❱ ",
    selection_caret = "󰜋 ",
    multi_icon = "󰒆 ",
    file_ignore_patterns = {
      "%.git/",
      "%.git$", -- git dir in submodules
      "node_modules/", -- node
      "venv/", -- python
      "%.app/", -- internals of mac apps
      "%.pxd", -- Pixelmator
      "%.plist$", -- Alfred
      "%.project-root$", -- harpoon/projects
      "%.png$",
      "%.gif$",
      "%.icns",
      "%.zip$",
      ".DS_Store", -- needs to be explicitly added, since unignored in some repos
      "%-bkp$", -- backup files
    }
    -- selection_caret = "󰜋 ",
    -- prompt_prefix = "❱ ",
    -- multi_icon = "󰒆 ",
    -- file_ignore_patterns = {
    --     "%.git/",
    --     "%.git$", -- git dir in submodules
    --     "node_modules/", -- node
    --     "venv/", -- python
    --     "%.app/", -- internals of mac apps
    --     "%.pxd", -- Pixelmator
    --     "%.plist$", -- Alfred
    --     "%.project-root$", -- harpoon/projects
    --     "%.png$",
    --     "%.gif$",
    --     "%.icns",
    --     "%.zip$",
    --     ".DS_Store", -- needs to be explicitly added, since unignored in some repos
    --     "%-bkp$", -- backup files
    -- },
  }
})

local remap = vim.keymap.set

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
remap('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
remap('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
remap('n', '<leader>b', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
remap('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

remap('n', '<leader>fp', require('telescope.builtin').git_files, { desc = '[F]ind [G]it Files' })
remap('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
remap('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
remap('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]find current [W]ord' })
remap('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind by [G]rep' })
remap('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
remap('n', '<leader>fr', require('telescope.builtin').resume, { desc = '[F]ind [R]esume' })

