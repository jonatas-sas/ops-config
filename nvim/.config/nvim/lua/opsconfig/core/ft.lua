-- NOTE:  Custom filetypes and formatting config integration
-- This file unifies filetype detection with Conform formatter rules

vim.api.nvim_create_autocmd({
  'VimEnter',
  'BufReadPre',
  'BufNewFile',
}, {
  callback = function()
    vim.filetype.add({
      extension = {
        nginx = 'nginx',
        neon = 'yaml',
        phtml = 'phtml',
        pconf = 'phpconfig',
      },

      filename = {
        ['.bashrc'] = 'sh',
        ['.projectrc'] = 'sh',
        ['.bash_custom'] = 'bash',
        ['.bash_logout'] = 'bash',
        ['.bash_ps1'] = 'bash',
        ['.bash_profile'] = 'bash',
        ['.taskrc'] = 'ini',
        ['taskrc'] = 'ini',
      },

      pattern = {
        ['.*/views/.*%.php'] = 'phtml',
        ['.*/partials/.*%.php'] = 'phtml',
        ['.*/config/.*%.php'] = 'phpconfig',
        ['.*/migrations/.*%.php'] = 'yiimigrations',
      },
    })
  end,
})
