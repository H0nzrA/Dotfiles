return {
  -- virtual plugin: no external repo, just runs local code
  "nvim-lua/plenary.nvim", -- any dummy dep, or use the trick below
  name = "func_counter",
  lazy = false,
  config = function()
    local ns = vim.api.nvim_create_namespace("func_counter")

    local function count_functions(bufnr)
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local func_start = nil

      for i, line in ipairs(lines) do
        if line:match("%b()") and line:match("{%s*$") or line:match("^{%s*$") then
          func_start = i
        end

        if line:match("^}") and func_start then
          local count = i - func_start - 1
          local text, hl

          if count > 25 then
            text = string.format(" <--- %d lines  ⚠ norm exceeded! ---> ", count)
            hl = "DiagnosticError"
          elseif count >= 20 then
            text = string.format(" <--- %d lines  ⚠ close to limit ---> ", count)
            hl = "DiagnosticWarn"
          else
            text = string.format(" <--- %d lines ---> ", count)
            hl = "DiagnosticHint"
          end

          vim.api.nvim_buf_set_extmark(bufnr, ns, i - 1, 0, {
            virt_text = { { text, hl } },
            virt_text_pos = "eol",
          })

          func_start = nil
        end
      end
    end

    vim.api.nvim_create_autocmd(
      { "BufEnter", "BufWritePost", "TextChanged", "InsertLeave" },
      {
        pattern = { "*.c", "*.h" },
        callback = function(ev)
          count_functions(ev.buf)
        end,
      }
    )
  end,
}
