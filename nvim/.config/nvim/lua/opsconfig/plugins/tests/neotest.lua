local plugins = vim.g.opsconfig.plugins

return {
  -- NOTE:   Modular test framework for Neovim.
  --   Supports multiple languages and test frameworks.
  --   Integrates with Treesitter, LSP, and custom interfaces.
  --   Enables asynchronous execution and detailed result display.
  --   Repository: https://github.com/nvim-neotest/neotest
  'nvim-neotest/neotest',

  enabled = plugins.neotest and plugins.plenary and plugins.treesitter and plugins.neotest_go and plugins.neotest_php,

  dependencies = {
    { 'nvim-neotest/neotest-go', enabled = true },
    { 'olimorris/neotest-phpunit', enabled = true },
    { 'nvim-lua/plenary.nvim', enabled = true },
    { 'nvim-treesitter/nvim-treesitter', enabled = true },
  },

  config = function()
    local neotest = require('neotest')

    neotest.setup({
      adapters = {
        require('neotest-go')({
          experimental = {
            test_table = true,
          },
          args = { '-count=1', '-timeout=60s' },
        }),
        require('neotest-phpunit'),
      },
    })

    -- Run nearest test
    vim.keymap.set('n', '<leader>rt', function()
      neotest.run.run()
    end, { desc = '[R]un Nearest [T]est' })

    -- Run current file tests
    vim.keymap.set('n', '<leader>rf', function()
      neotest.run.run(vim.fn.expand('%'))
    end, { desc = '[R]un [F]ile Tests' })

    -- Stop test run
    vim.keymap.set('n', '<leader>rs', function()
      neotest.run.stop()
    end, { desc = '[R]un: [S]top Test' })

    -- Toggle summary panel
    vim.keymap.set('n', '<leader>ro', function()
      neotest.summary.toggle()
    end, { desc = '[R]esult: Toggle [O]verview (Summary)' })

    -- Open output (last run)
    vim.keymap.set('n', '<leader>rO', function()
      neotest.output.open({ enter = true })
    end, { desc = '[R]esult: Open [O]utput' })

    -- Toggle output panel (persistent)
    vim.keymap.set('n', '<leader>rp', function()
      neotest.output_panel.toggle()
    end, { desc = '[R]esult: Toggle [P]anel' })

    -- Watch file for changes and re-run
    vim.keymap.set('n', '<leader>rw', function()
      neotest.watch.watch()
    end, { desc = '[R]un: [W]atch Test File' })
  end,
}
