return {
  -- NOTE:  Configura automaticamente o Lua Language Server (LuaLS) para editar configurações do Neovim.
  --  Atualiza dinamicamente as bibliotecas do workspace com base nos módulos requeridos.
  --  Oferece integração com nvim-cmp e outras fontes de conclusão para declarações `require`.
  --  Repositório: https://github.com/folke/lazydev.nvim
  'folke/lazydev.nvim',

  enabled = vim.g.opsconfig.plugins.lazydev_nvim,

  ft = 'lua',

  opts = {
    library = {
      {
        path = '${3rd}/luv/library',
        words = {
          'vim%.uv',
        },
      },
      {
        path = 'lazy.nvim',
        words = {
          'LazyVim',
        },
      },
    },
  },
}
