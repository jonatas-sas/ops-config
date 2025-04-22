return {
  -- NOTE:  PHPUnit adapter for the Neotest framework.
  --  Enables running and debugging PHP tests using PHPUnit within Neovim.
  --  Provides detailed test feedback, diagnostics, and async execution.
  --  Fully configurable and integrates seamlessly with neotest core features.
  --  Repository: https://github.com/olimorris/neotest-phpunit
  'olimorris/neotest-phpunit',

  enabled = vim.g.opsconfig.plugins.neotest_php,
}
