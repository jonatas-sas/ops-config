return {
  dir = '/workspace/development/adm/nvim/ntask.nvim',
  enabled = false,
  -- 'OpsConfigIT/ntask.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    require('ntask').setup({})
  end,
}
