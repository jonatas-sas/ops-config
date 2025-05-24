-- Keymaps

---@class KeymapDef
---@field modes string|string[] Modes in which the keymap applies ('n', 'i', 'v', etc.)
---@field lhs string Left-hand side (the keybind)
---@field rhs string|function Right-hand side (the command or function to execute)
---@field desc string Description of the keymap
---@field opts table Optional keymap options (like { silent = true })
---@field enabled boolean Whether the keymap is active

---Returns a list of global keymaps.
---@return KeymapDef[]
local keymaps = function()
  return {
    -- SECTION: Global Keymaps
    -- SUBSECTION: Insert Mode Exits
    {
      modes = 'i',
      lhs = 'jk',
      rhs = '<ESC>',
      desc = 'Exit insert mode with jk',
      opts = {},
      enabled = true,
    },
    {
      modes = 'i',
      lhs = 'jj',
      rhs = '<ESC>',
      desc = 'Exit insert mode with jj',
      opts = {},
      enabled = true,
    },
    {
      modes = 'i',
      lhs = 'kk',
      rhs = '<ESC>',
      desc = 'Exit insert mode with kk',
      opts = {},
      enabled = true,
    },
    {
      modes = 'i',
      lhs = ':w',
      rhs = '<ESC>:w<CR>',
      desc = 'Exit insert and save',
      opts = {},
      enabled = true,
    },
    {
      modes = 'i',
      lhs = ':W',
      rhs = '<ESC>:w<CR>',
      desc = 'Exit insert and save',
      opts = {},
      enabled = true,
    },

    -- SUBSECTION: Buffer Management
    {
      modes = 'n',
      lhs = '<leader>bo',
      rhs = ':%bd|e#|bd#<CR>',
      desc = 'Close all Buffers except Current',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>bb',
      rhs = ':ls<CR>',
      desc = 'List all Buffers',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>bd',
      rhs = ':bd<CR>',
      desc = 'Delete Current Buffer',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>bn',
      rhs = ':bnext<CR>',
      desc = 'Next Buffer',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>bp',
      rhs = ':bprevious<CR>',
      desc = 'Previous Buffer',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<TAB>',
      rhs = ':bnext<CR>',
      desc = 'Next Buffer (tab)',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<S-TAB>',
      rhs = ':bprevious<CR>',
      desc = 'Previous Buffer (shift-tab)',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>bO',
      rhs = function()
        local current = vim.api.nvim_get_current_buf()

        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if buf ~= current and vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == '' then
            vim.cmd('bd ' .. buf)
          end
        end
      end,
      desc = 'Close all Other Buffers (safe)',
      opts = {},
      enabled = true,
    },

    -- SUBSECTION: Search and Reload
    {
      modes = 'n',
      lhs = '<leader>nh',
      rhs = ':nohl<CR>',
      desc = 'Clear Search Highlights',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>rl',
      rhs = ':source %<CR>',
      desc = 'Reload Lua File',
      opts = {},
      enabled = true,
    },

    -- SUBSECTION: Plugin Managers
    {
      modes = 'n',
      lhs = '<leader>lz',
      rhs = ':Lazy<CR>',
      desc = 'Lazy Plugin Manager',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>lm',
      rhs = ':Mason<CR>',
      desc = 'Mason Plugin Manager',
      opts = {},
      enabled = true,
    },

    -- SUBSECTION: Marks
    {
      modes = 'n',
      lhs = '<leader>cm',
      rhs = ':delmarks a-zA-Z0-9<CR>',
      desc = 'Clear Markers',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>ma',
      rhs = ':marks<CR>',
      desc = 'List all Marks',
      opts = {},
      enabled = true,
    },

    -- SUBSECTION: Window Management
    {
      modes = 'n',
      lhs = '<leader>wv',
      rhs = '<C-w>v',
      desc = 'Split Window Vertically',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>wh',
      rhs = '<C-w>s',
      desc = 'Split Window Horizontally',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>we',
      rhs = '<C-w>=',
      desc = 'Make Window Splits Equal Size',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>wx',
      rhs = '<cmd>close<CR>',
      desc = 'Close Current Split',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<C-Up>',
      rhs = ':resize +2<CR>',
      desc = 'Increase Window Height',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<C-Down>',
      rhs = ':resize -2<CR>',
      desc = 'Decrease Window Height',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<C-Left>',
      rhs = ':vertical resize -2<CR>',
      desc = 'Decrease Window Width',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<C-Right>',
      rhs = ':vertical resize +2<CR>',
      desc = 'Increase Window Width',
      opts = {},
      enabled = true,
    },

    -- SUBSECTION: Tab Management
    {
      modes = 'n',
      lhs = '<leader>to',
      rhs = '<cmd>tabnew<CR>',
      desc = 'Open New Tab',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>tx',
      rhs = '<cmd>tabclose<CR>',
      desc = 'Close Current Tab',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>tn',
      rhs = '<cmd>tabn<CR>',
      desc = 'Go to Next Tab',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>tp',
      rhs = '<cmd>tabp<CR>',
      desc = 'Go to Previous Tab',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>tf',
      rhs = '<cmd>tabnew %<CR>',
      desc = 'Open Current Buffer in New Tab',
      opts = {},
      enabled = true,
    },

    -- SUBSECTION: Arrow Key Disabling
    {
      modes = { 'n', 'v' },
      lhs = '<left>',
      rhs = '<cmd>echo \'Use h instead\'<CR>',
      desc = 'Disable left arrow',
      opts = {},
      enabled = true,
    },
    {
      modes = { 'n', 'v' },
      lhs = '<right>',
      rhs = '<cmd>echo \'Use l instead\'<CR>',
      desc = 'Disable right arrow',
      opts = {},
      enabled = true,
    },
    {
      modes = { 'n', 'v' },
      lhs = '<up>',
      rhs = '<cmd>echo \'Use k instead\'<CR>',
      desc = 'Disable up arrow',
      opts = {},
      enabled = true,
    },
    {
      modes = { 'n', 'v' },
      lhs = '<down>',
      rhs = '<cmd>echo \'Use j instead\'<CR>',
      desc = 'Disable down arrow',
      opts = {},
      enabled = true,
    },

    -- SUBSECTION: Line Movement
    {
      modes = 'n',
      lhs = '<C-A-j>',
      rhs = ':m .+1<CR>==',
      desc = 'Move line down',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<C-A-k>',
      rhs = ':m .-2<CR>==',
      desc = 'Move line up',
      opts = {},
      enabled = true,
    },

    -- SUBSECTION: Navigation
    {
      modes = 'n',
      lhs = 'H',
      rhs = '^',
      desc = 'Go to beginning of line',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = 'L',
      rhs = 'g_',
      desc = 'Go to end of visual line',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = ']b',
      rhs = ']}',
      desc = 'Next block',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '[b',
      rhs = '[{',
      desc = 'Previous block',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<C-d>',
      rhs = '<C-d>zz',
      desc = 'Scroll down and center',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<C-u>',
      rhs = '<C-u>zz',
      desc = 'Scroll up and center',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = 'n',
      rhs = 'nzzzv',
      desc = 'Next search result and center',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = 'N',
      rhs = 'Nzzzv',
      desc = 'Prev search result and center',
      opts = {},
      enabled = true,
    },

    -- SUBSECTION: Quickfix and Location List
    {
      modes = 'n',
      lhs = '<leader>qo',
      rhs = ':copen<CR>',
      desc = 'Open quickfix list',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>qc',
      rhs = ':cclose<CR>',
      desc = 'Close quickfix list',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>qn',
      rhs = ':cnext<CR>',
      desc = 'Next item in quickfix',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>qp',
      rhs = ':cprev<CR>',
      desc = 'Previous item in quickfix',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>lo',
      rhs = ':lopen<CR>',
      desc = 'Open location list',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>lc',
      rhs = ':lclose<CR>',
      desc = 'Close location list',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>ln',
      rhs = ':lnext<CR>',
      desc = 'Next item in location list',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>lp',
      rhs = ':lprev<CR>',
      desc = 'Previous item in location list',
      opts = {},
      enabled = true,
    },

    -- SUBSECTION: Lua Execution
    {
      modes = 'n',
      lhs = '<leader>lx',
      rhs = ':lua <C-r>=getline(\'.\')<CR><CR>',
      desc = 'Execute current line as Lua',
      opts = {},
      enabled = true,
    },
    {
      modes = 'v',
      lhs = '<leader>lx',
      rhs = ':<C-u>lua loadstring(table.concat(vim.fn.getline(\'.\', \'.\'), \'\\n\'))()<CR>',
      desc = 'Execute selection as Lua',
      opts = {},
      enabled = true,
    },

    -- SUBSECTION: Line Insertion Without Insert Mode
    {
      modes = 'n',
      lhs = 'go',
      rhs = 'o<Esc>k',
      desc = 'Add new line below without entering insert mode',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = 'gO',
      rhs = 'O<Esc>j',
      desc = 'Add new line above without entering insert mode',
      opts = {},
      enabled = true,
    },

    -- SUBSECTION: LSP
    {
      modes = 'n',
      lhs = 'gd',
      rhs = vim.lsp.buf.definition,
      desc = 'Go to Definition',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = 'gD',
      rhs = vim.lsp.buf.declaration,
      desc = 'Go to Declaration',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = 'gr',
      rhs = vim.lsp.buf.references,
      desc = 'Find References',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = 'gI',
      rhs = vim.lsp.buf.implementation,
      desc = 'Go to Implementation',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>lD',
      rhs = vim.lsp.buf.type_definition,
      desc = 'Type Definition',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>le',
      rhs = vim.diagnostic.open_float,
      desc = 'Show Error',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>lrn',
      rhs = vim.lsp.buf.rename,
      desc = 'Rename Symbol',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>lca',
      rhs = vim.lsp.buf.code_action,
      desc = 'Code Action',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>lws',
      rhs = vim.lsp.buf.workspace_symbol,
      desc = 'Workspace Symbols',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>lds',
      rhs = vim.lsp.buf.document_symbol,
      desc = 'Document Symbols',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>lF',
      rhs = function()
        vim.lsp.buf.format({ async = true })
      end,
      desc = 'Format Code',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>lcl',
      rhs = vim.lsp.codelens.run,
      desc = 'Run CodeLens',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>lcL',
      rhs = vim.lsp.codelens.refresh,
      desc = 'Refresh CodeLens',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>lR',
      rhs = function()
        for _, client in pairs(vim.lsp.get_active_clients()) do
          client.stop()
        end

        vim.defer_fn(function()
          local configs = require('lspconfig.configs')

          for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buftype == '' then
              for _, config in pairs(configs) do
                if config.manager then
                  config.manager.try_add(bufnr)
                end
              end
            end
          end
        end, 100)
      end,
      desc = 'Restart LSP and reattach to all buffers',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>lif',
      rhs = '<cmd>LspInfo<CR>',
      desc = 'Show LSP info',
      opts = {},
      enabled = true,
    },

    -- SECTION: Plugins

    -- SUBSECTION: AutoSave
    -- Plugin Configuration File: ../plugins/buffers/auto-save.lua
    {
      modes = 'n',
      lhs = '<leader>ua',
      rhs = '<cmd>AutoSaveToggleNotify<CR>',
      desc = 'Toggle AutoSave',
      opts = {},
      enabled = true,
    },

    -- SUBSECTION: NvimTree
    -- Plugin Configuration File: ../plugins/file-explorer/nvim-tree.lua
    -- INFO: On Atach Maps:
    -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
    -- vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    {
      modes = 'n',
      lhs = '<leader>ee',
      rhs = '<cmd>NvimTreeToggle<CR>',
      desc = 'Toggle File Explorer',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>er',
      rhs = '<cmd>NvimTreeRefresh<CR>',
      desc = 'File Explorer: Refresh',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>ec',
      rhs = '<cmd>NvimTreeCollapse<CR>',
      desc = 'File Explorer: Collapse',
      opts = {},
      enabled = true,
    },

    -- SUBSECTION: Conform
    -- Plugin Configuration File: ../plugins/conform/conform.lua
    {
      modes = { 'n', 'v' },
      lhs = '<leader>ff',
      rhs = function()
        vim.lsp.buf.format({ async = true })
      end,
      desc = 'Format File or Range',
      opts = {},
      enabled = true,
    },

    -- SUBSECTION: Trouble
    -- Plugin Configuration File: ../plugins/development/trouble.lua
    {
      modes = 'n',
      lhs = '<leader>xx',
      rhs = '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>xX',
      rhs = '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>cs',
      rhs = '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>cl',
      rhs = '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>xL',
      rhs = '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
      opts = {},
      enabled = true,
    },
    {
      modes = 'n',
      lhs = '<leader>xQ',
      rhs = '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
      opts = {},
      enabled = true,
    },

    -- SUBSECTION: Telescope
    -- Plugin Configuration File: ../plugins/telescope/telescope.lua
    -- {
    --   modes = 'n',
    --   lhs = '<leader>sf',
    --   rhs = function() end,
    --   desc = 'Find Files',
    --   opts = {},
    --   enabled = true,
    -- },
    -- {
    --   modes = 'n',
    --   lhs = '<leader>fg',
    --   rhs = helpers.telescope.live_grep,
    --   desc = 'Live Grep',
    --   opts = {},
    --   enabled = true,
    -- },
  }
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyDone',
  callback = function()
    for _, keymap in ipairs(keymaps()) do
      local opts = { noremap = true, silent = true }
      local desc = keymap.desc .. ' [' .. string.gsub(keymap.lhs, '<leader>', 'SPC ') .. ']'

      opts = vim.tbl_extend('force', opts, { desc = desc })

      if keymap.enabled then
        vim.keymap.set(keymap.modes, keymap.lhs, keymap.rhs, opts)
      end
    end
  end,
})
