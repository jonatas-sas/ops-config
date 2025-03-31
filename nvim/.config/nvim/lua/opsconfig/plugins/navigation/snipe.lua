return {
  -- NOTE:  Movimentação rápida e precisa no Neovim.
  --  Inspirado no EasyMotion/Lightspeed, permite "pular" para qualquer caractere.
  --  Aumenta a eficiência na navegação por trechos de código ou texto.
  --  Leve e configurável, com suporte a atalhos intuitivos e múltiplos modos.
  --  Repositório: https://github.com/leath-dub/snipe.nvim
  'leath-dub/snipe.nvim',

  enabled = vim.g.opsconfig.plugins.snipe_nvim and vim.g.opsconfig.plugins.which_key_nvim,

  dependencies = {
    -- NOTE:  Mostra dicas de atalhos no Neovim em tempo real.
    --  Exibe combinações de teclas disponíveis ao pressionar um prefixo.
    --  Ajuda a memorizar atalhos e melhorar a produtividade.
    --  Totalmente configurável, com suporte a grupos e descrições personalizadas.
    --  Repositório: https://github.com/folke/which-key.nvim
    {
      'folke/which-key.nvim',
      enabled = true,
    },
  },

  config = function()
    local snipe = require('snipe')

    -- Setup {{{

    snipe.setup({
      ---@type integer
      max_height = -1, -- -1 means dynamic height

      -- Where to place the ui window
      -- Can be any of "topleft", "bottomleft", "topright", "bottomright", "center", "cursor" (sets under the current cursor pos)
      ---@type "topleft"|"bottomleft"|"topright"|"bottomright"|"center"|"cursor"
      position = 'topleft',

      -- Override options passed to `nvim_open_win`
      -- Be careful with this as snipe will not validate
      -- anything you override here. See `:h nvim_open_win`
      -- for config options
      ---@type vim.api.keyset.win_config
      open_win_override = {
        title = 'Buffers',
        border = 'rounded',
      },

      -- Preselect the currently open buffer
      preselect_current = false,

      -- Set a function to preselect the currently open buffer
      -- E.g, `preselect = require("snipe").preselect_by_classifier("#")` to
      -- preselect alternate buffer (see :h ls and look at the "Indicators")
      ---@type nil|fun(buffers: snipe.Buffer[]): number
      preselect = nil, -- function (bs: Buffer[] [see lua/snipe/buffer.lua]) -> int (index)

      -- Changes how the items are aligned: e.g. "<tag> foo    " vs "<tag>    foo"
      -- Can be "left", "right" or "file-first"
      -- NOTE: "file-first" puts the file name first and then the directory name
      ---@type "left"|"right"|"file-first"
      text_align = 'left',

      -- Provide custom buffer list format
      -- Available options:
      --  "filename" - basename of the buffer
      --  "directory" - buffer parent directory path
      --  "icon" - icon for buffer filetype from "mini.icons" or "nvim-web-devicons"
      --  string - any string, will be inserted as is
      --  fun(buffer_object): string,string - function that takes snipe.Buffer object as an argument
      --    and returns a string to be inserted and optional highlight group name
      -- buffer_format = { "->", "icon", "filename", "", "directory", function(buf)
      --   if vim.fn.isdirectory(vim.api.nvim_buf_get_name(buf.id)) == 1 then
      --     return " ", "SnipeText"
      --   end
      -- end },

      hints = {
        -- Charaters to use for hints
        -- make sure they don't collide with the navigation keymaps
        -- If you remove `j` and `k` from below, you can navigate in the plugin
        -- dictionary = "sadflewcmpghio",
        dictionary = 'saflewcmpgi',
      },

      navigate = {
        -- When the list is too long it is split into pages
        -- `[next|prev]_page` options allow you to navigate
        -- this list
        next_page = 'J',
        prev_page = 'K',

        -- You can also just use normal navigation to go to the item you want
        -- this option just sets the keybind for selecting the item under the
        -- cursor
        under_cursor = '<cr>',

        -- In case you changed your mind, provide a keybind that lets you
        -- cancel the snipe and close the window.
        ---@type string|string[]
        cancel_snipe = '<esc>',

        -- Close the buffer under the cursor
        -- Remove "j" and "k" from your dictionary to navigate easier to delete
        -- NOTE: Make sure you don't use the character below on your dictionary
        close_buffer = 'D',

        -- Open buffer in vertical split
        open_vsplit = 'V',

        -- Open buffer in split, based on `vim.opt.splitbelow`
        open_split = 'H',

        -- Change tag manually
        change_tag = 'C',
      },

      -- Define the way buffers are sorted by default
      -- Can be any of "default" (sort buffers by their number) or "last" (sort buffers by last accessed)
      -- If you choose "last", it will be modifying sorting the boffers by last
      -- accessed, so the "a" will always be assigned to your latest accessed
      -- buffer
      -- If you want the letters not to change, leave the sorting at default
      sort = 'default',
    })

    -- }}}

    -- Keymaps {{{

    local wk = require('which-key')

    wk.add({
      { '<leader>b', group = 'Buffers', icon = '󰈔' },

      {
        '<leader>bb',
        function()
          snipe.open_buffer_menu()
        end,
        desc = '[B]uffer [B]rowser',
        icon = { color = 'blue', icon = '' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        'gb',
        function()
          snipe.open_buffer_menu()
        end,
        desc = 'Goto Buffer',
        icon = { color = 'blue', icon = '' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
    })

    -- }}}
  end,
}
