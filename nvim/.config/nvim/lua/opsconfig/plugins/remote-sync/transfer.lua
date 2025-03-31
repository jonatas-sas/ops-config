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
    -- NOTE:  Mostra dicas de atalhos no Neovim em tempo real.
    --  Exibe combinações de teclas disponíveis ao pressionar um prefixo.
    --  Ajuda a memorizar atalhos e melhorar a produtividade.
    --  Totalmente configurável, com suporte a grupos e descrições personalizadas.
    --  Repositório: https://github.com/folke/which-key.nvim
    {
      'folke/which-key.nvim',
      enabled = vim.g.opsconfig.plugins.which_key_nvim,
    },
  },

  cmd = { 'TransferInit', 'DiffRemote', 'TransferUpload', 'TransferDownload', 'TransferDirDiff', 'TransferRepeat' },

  opts = {},
}
