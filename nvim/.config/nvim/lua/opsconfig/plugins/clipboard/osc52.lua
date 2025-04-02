return {
  -- NOTE:  Copia conteúdo do Neovim para o clipboard via protocolo OSC52.
  --  Suporte a terminais remotos (SSH, tmux) sem depender do sistema operacional.
  --  Ideal para ambientes headless, WSL e servidores remotos.
  --  Configurável, com suporte a seleção automática e integração com yanks.
  --  Repositório: https://github.com/ojroques/nvim-osc52
  'ojroques/nvim-osc52',

  event = 'VeryLazy',

  enabled = vim.g.opsconfig.plugins.osc52,

  config = function()
    local osc52 = require('osc52')

    osc52.setup({
      trim = false,
      tmux_passthrough = true,
    })

    vim.api.nvim_create_autocmd('TextYankPost', {
      callback = function()
        if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
          if vim.g.opsconfig.global.is_servers then
            osc52.copy_register('"')
          else
            osc52.copy_register('+')
          end
        end
      end,
    })
  end,
}
