require('lualine').setup{
    options = {
        theme = 'auto',
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {'buffers'},
        lualine_x = {'tabs'},
        lualine_y = {
            {
                function()
                    local lsps = vim.lsp.get_active_clients({ bufnr = vim.fn.bufnr() })
                    local icon = require("nvim-web-devicons").get_icon_by_filetype(
                            vim.api.nvim_buf_get_option(0, "filetype")
                        )
                    if lsps and #lsps > 0 then
                        local names = {}
                        for _, lsp in ipairs(lsps) do
                            table.insert(names, lsp.name)
                        end
                        return string.format("%s %s", table.concat(names, ", "), icon)
                    else
                        return icon or ""
                    end
                end,
                on_click = function()
                    vim.api.nvim_command("LspInfo")
                end,
                color = function()
                    local _, color = require("nvim-web-devicons").get_icon_cterm_color_by_filetype(
                            vim.api.nvim_buf_get_option(0, "filetype")
                        )
                    return { fg = color }
                end,
            },
            'encoding',
            'progress'},
        lualine_z = {
            {
                'diagnostics',
                sources = {'nvim_diagnostic', 'nvim_lsp'},
                sections = {'error', 'warn', 'info', 'hint'},
                diagnostics_color = {
                    error = 'DiagnosticError',
                    warn = 'DiagnosticWarn',
                    info = 'DiagnosticInfo',
                    hint = 'DiagnosticHint',
                },
                symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '},
                colored = true,
                update_in_insert = false,
                always_visible = false,
            }
        }
    }
}
