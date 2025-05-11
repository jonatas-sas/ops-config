return {
  -- NOTE:  Plugin para transferir texto, arquivos e buffers no Neovim.
  --  Suporte a compartilhamento via pastebin, 0x0, FTP, SFTP e outros serviços.
  --  Facilita a troca rápida de conteúdos entre dispositivos e colaboradores.
  --  Configurável, permitindo escolher serviços e opções de upload.
  --  Repositório: https://github.com/coffebar/transfer.nvim
  'coffebar/transfer.nvim',

  enabled = vim.g.opsconfig.plugins.transfer_nvim,

  lazy = true,

  depends = {
    {
      'folke/which-key.nvim',
      enabled = vim.g.opsconfig.plugins.which_key_nvim,
    },
  },

  cmd = {
    'TransferInit',
    'DiffRemote',
    'TransferUpload',
    'TransferDownload',
    'TransferDirDiff',
    'TransferRepeat',
  },

  opts = {},

  config = function()
    -- SECTION: Keymaps
    local wk = require('which-key')

    wk.add({
      { '<leader>rs', group = 'Remote Server (Upload or Download)', icon = '' },
      {
        '<leader>rsd',
        '<cmd>TransferDownload<cr>',
        desc = '[R]emote [S]erver: [D]ownload',
        icon = { color = 'green', icon = '󰇚' },
      },
      {
        '<leader>rsf',
        '<cmd>DiffRemote<cr>',
        desc = '[R]emote [S]erver: Di[f]f',
        icon = { color = 'green', icon = '' },
      },
      {
        '<leader>rsi',
        '<cmd>TransferInit<cr>',
        desc = '[R]emote [S]erver: [I]nit/Edit Deployment Config',
        icon = { color = 'green', icon = '' },
      },
      {
        '<leader>rsr',
        '<cmd>TransferRepeat<cr>',
        desc = '[R]emote [S]erver: [R]epeat Transfer Command',
        icon = { color = 'green', icon = '󰑖' },
      },
      {
        '<leader>rsu',
        '<cmd>TransferUpload<cr>',
        desc = '[R]emote [S]erver: [U]pload',
        icon = { color = 'green', icon = '󰕒' },
      },
    })
  end,
}
