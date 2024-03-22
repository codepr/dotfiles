local bufnr = -1

function run_test_at_cursor()
    local current_file = vim.fn.expand('%:p')
    local current_line = vim.api.nvim__buf_stats(0).current_lnum

    -- Build the right test command
    local mix_command = function(filename, linenr)
        local path = filename .. ":" .. linenr
        if string.find(filename, "unit_test") then
            return {"mix", "unit_test", path, "--warnings-as-errors" }
        else
            return {"mix", "test", path, "--warnings-as-errors" }
        end
    end

    print(table.concat(mix_command(current_file, current_line), " "))

    -- Append to output
    local log = function(_, data)
        if data then
            -- Make it temporarily writable so we don't have warnings.
            vim.api.nvim_buf_set_option(bufnr, "readonly", false)

            -- Append the data.
            vim.api.nvim_buf_set_lines(bufnr, -1, -1, true, data)

            -- Mark as not modified, otherwise you'll get an error when
            -- attempting to exit vim.
            vim.api.nvim_buf_set_option(bufnr, "modified", false)

            -- Make readonly again.
            vim.api.nvim_buf_set_option(bufnr, "readonly", true)

            -- Get the window the buffer is in and set the cursor position to the bottom.
            local buffer_window = vim.api.nvim_call_function("bufwinid", { bufnr })
            local buffer_line_count = vim.api.nvim_buf_line_count(bufnr)
            vim.api.nvim_win_set_cursor(buffer_window, { buffer_line_count, 0 })
        end
    end

    -- Open a buffer if not already created
    local open_buffer = function()
        -- Get a boolean that tells us if the buffer number is visible anymore.
        --
        -- :help bufwinnr
        local buffer_visible = vim.api.nvim_call_function("bufwinnr", { bufnr }) ~= -1

        if bufnr == -1 or not buffer_visible then
            -- Create a new buffer with the name "AUTOTEST_OUTPUT".
            -- Same name will reuse the current buffer.
            vim.api.nvim_command("new Test at point")

            -- Collect the buffer's number.
            bufnr = vim.api.nvim_get_current_buf()

            -- Mark the buffer as readonly.
            vim.opt_local.readonly = true
        end

    end

    open_buffer()
    -- Clear the buffer's contents incase it has been used.
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, {})

    vim.fn.jobstart(mix_command(current_file, current_line), {
        stdout_buffered = true,
        on_stdout = log,
        on_stderr = log,
    })
end
