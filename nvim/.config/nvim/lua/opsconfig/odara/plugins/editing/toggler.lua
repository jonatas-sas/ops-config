return {
  -- NOTE:  Plugin para alternar valores booleanos no Neovim.
  --  Troca rapidamente entre `true` ⇄ `false`, `yes` ⇄ `no`, entre outros.
  --  Permite adicionar pares personalizados para alternância.
  --  Útil para edição rápida de configurações e código.
  --  Repositório: https://github.com/nguyenvukhang/nvim-toggler
  'nguyenvukhang/nvim-toggler',

  enabled = vim.g.opsconfig.plugins.nvim_toggler,

  config = function()
    local toggler = require('nvim-toggler')

    toggler.setup({
      inverses = {
        ['true'] = 'false',
        ['on'] = 'off',
        ['yes'] = 'no',
        ['enable'] = 'disable',
        ['enabled'] = 'disabled',
        ['and'] = 'or',
      },
      remove_default_keybinds = true,
      remove_default_inverses = true,
      autoselect_longest_match = false,
    })

    vim.keymap.set({ 'n', 'v' }, 'tt', toggler.toggle, { desc = '[T]oggle [T]rue and other booleans formats.' })
  end,
}
