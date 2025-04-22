return {
  -- NOTE:   Neotest adapter for Go tests.
  --   Allows running, debugging, and viewing Go tests directly in Neovim.
  --   Integrates with `go test` and supports asynchronous execution.
  --   Compatible with `neotest`, providing detailed test feedback.
  --   Repository: https://github.com/nvim-neotest/neotest-go
  'nvim-neotest/neotest-go',

  enabled = vim.g.opsconfig.plugins.neotest_go,
}
