return {
  -- NOTE:  Gerencia terminais flutuantes, verticais e horizontais no Neovim.
  --  Suporte a múltiplas instâncias e persistência de sessões.
  --  Fácil alternância entre terminal e edição sem sair do Neovim.
  --  Configuração flexível com atalhos personalizáveis.
  --  Repositório: https://github.com/akinsho/toggleterm.nvim
  'akinsho/toggleterm.nvim',

  enabled = vim.g.opsconfig.plugins.toggleterm_nvim,

  version = '*',

  config = function()
    local terminal = require('toggleterm')
    local options = {
      autochdir = false,
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = 'float',
      close_on_exit = true,
      clear_env = false,
      auto_scroll = true,
    }

    terminal.setup(options)

    local Terminal = require('toggleterm.terminal').Terminal

    function _G.OpenLocalTerminal()
      local cwd = vim.fn.expand('%:p:h')

      if cwd == '' then
        cwd = vim.loop.cwd()
      end

      if not options then
        return
      end

      local local_options = vim.deepcopy(options)

      local_options.dir = cwd

      local term = Terminal:new(local_options)

      term:toggle()
    end

    local keymap = vim.keymap

    keymap.set('n', '<leader>ot', '<cmd>ToggleTerm<CR>', { desc = '[O]pen [T]erminal' })
    keymap.set(
      'n',
      '<leader>th',
      '<cmd>lua OpenLocalTerminal()<CR>',
      { desc = '[T]erminal [H]ere (current buffer dir)', noremap = true, silent = true }
    )
  end,
}
