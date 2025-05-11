return {
  name = 'PHPStan',
  cmd = 'phpstan',
  stdin = false,
  append_filename = true,
  args = {
    'analyse',
    '--error-format=json',
    '--level=max',
    '--no-progress',
    '--no-interaction',
  },
  ignore_exitcode = true,
  parser = function(output, bufnr)
    if output == nil or output == '' then
      return {}
    end

    local decoded = vim.fn.json_decode(output)

    if not decoded or not decoded.files then
      return {}
    end

    local diagnostics = {}

    for _, file in pairs(decoded.files) do
      for _, message in ipairs(file.messages) do
        local severity = vim.diagnostic.severity.WARN

        if message.message:match('error') then
          severity = vim.diagnostic.severity.ERROR
        elseif message.message:match('deprecated') then
          severity = vim.diagnostic.severity.WARN
        elseif message.message:match('notice') or message.message:match('info') then
          severity = vim.diagnostic.severity.INFO
        end

        table.insert(diagnostics, {
          bufnr = bufnr,
          lnum = message.line - 1,
          col = 0,
          message = '󰘦 ' .. message.message .. ' by PHPStan',
          severity = severity,
          source = 'phpstan',
        })
      end
    end

    return diagnostics
  end,
}
