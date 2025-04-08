return {
  name = 'PHPCS',
  cmd = 'phpcs',
  stdin = false,
  append_filename = true,
  args = {
    '--standard=PSR12',
    '--report=json',
  },
  ignore_exitcode = true,
  parser = function(output, bufnr)
    local decoded = vim.fn.json_decode(output)
    local diagnostics = {}

    if decoded and decoded.files then
      for _, file in pairs(decoded.files) do
        for _, message in ipairs(file.messages) do
          table.insert(diagnostics, {
            bufnr = bufnr,
            lnum = message.line - 1,
            col = message.column - 1,
            message = '󰛿 ' .. message.message .. ' by PHPCS',
            severity = message.type == 'ERROR' and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN,
            source = 'phpcs',
          })
        end
      end
    end

    return diagnostics
  end,
}
