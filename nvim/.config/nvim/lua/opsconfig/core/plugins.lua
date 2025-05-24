return {
  {
    'ojroques/nvim-osc52',

    event = 'VeryLazy',

    config = function()
      local osc52 = require('osc52')

      osc52.setup({
        trim = false,
        tmux_passthrough = true,
      })

      vim.api.nvim_create_autocmd('TextYankPost', {
        callback = function()
          if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
            osc52.copy_register('"')
          end
        end,
      })
    end,
  },
}
