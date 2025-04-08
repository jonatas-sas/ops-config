return {
  name = 'GolangCI-Lint',
  cmd = 'golangci-lint',
  stdin = false,
  append_filename = true,
  args = {
    'run',
    '--output.json.path',
    'stdout',
    '--show-stats=false',
  },
  stream = 'stdout',
  ignore_exitcode = true,
  parser = function(output, bufnr)
    local diagnostics = {}

    local ok, decoded = pcall(vim.fn.json_decode, output)

    if not ok or not decoded or type(decoded.Issues) ~= 'table' then
      return diagnostics
    end

    local severities = {
      ['error'] = vim.diagnostic.severity.ERROR,
      ['warning'] = vim.diagnostic.severity.WARN,
      ['info'] = vim.diagnostic.severity.INFO,
      ['hint'] = vim.diagnostic.severity.HINT,
    }

    for _, issue in ipairs(decoded.Issues) do
      local severity = severities[(issue.Severity or ''):lower()] or vim.diagnostic.severity.ERROR

      table.insert(diagnostics, {
        bufnr = bufnr,
        lnum = issue.Pos.Line - 1,
        col = issue.Pos.Column - 1,
        end_lnum = issue.Pos.Line - 1,
        end_col = issue.Pos.Column,
        source = issue.FromLinter or 'golangci-lint',
        message = issue.Text or 'Unknown issue',
        severity = severity,
      })
    end

    return diagnostics
  end,
}
