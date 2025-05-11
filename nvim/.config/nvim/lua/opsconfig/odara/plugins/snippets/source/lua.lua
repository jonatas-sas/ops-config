local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node

return {
  s('wkplugin', {
    t({
      '-- NOTE:  Mostra dicas de atalhos no Neovim em tempo real.',
      '--  Exibe combinações de teclas disponíveis ao pressionar um prefixo.',
      '--  Ajuda a memorizar atalhos e melhorar a produtividade.',
      '--  Totalmente configurável, com suporte a grupos e descrições personalizadas.',
      '--  Repositório: https://github.com/folke/which-key.nvim',
      '{',
      '  \'folke/which-key.nvim\',',
      '  enabled = true,',
      '},',
    }),
  }),
}
