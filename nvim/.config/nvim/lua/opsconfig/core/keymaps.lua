--[[
General Keymaps for Neovim

This file defines essential and ergonomic key mappings to improve workflow and navigation.
Keymaps are grouped by functionality and follow traditional Vim behaviors, with enhancements
for modern plugin usage and faster file navigation.
--]]

local helpers = require('opsconfig.helpers.keymaps')
local map = helpers.map

-- SECTION: Global Keymaps

-- SUBSECTION: Insert Mode Exits
map('i', 'jk', '<ESC>', 'Exit insert mode with jk')
map('i', 'jj', '<ESC>', 'Exit insert mode with jj')
map('i', 'kk', '<ESC>', 'Exit insert mode with kk')
map('i', ':w', '<ESC>:w<CR>', 'Exit insert and save')
map('i', ':W', '<ESC>:w<CR>', 'Exit insert and save')

-- SUBSECTION: Buffer Management
map('n', '<leader>bo', ':%bd|e#|bd#<CR>', 'Close all Buffers except Current')
map('n', '<leader>bb', ':ls<CR>', 'List all buffers')
map('n', '<leader>bd', ':bd<CR>', 'Delete current buffer')
map('n', '<leader>bn', ':bnext<CR>', 'Next buffer')
map('n', '<leader>bp', ':bprevious<CR>', 'Previous buffer')
map('n', '<TAB>', ':bnext<CR>', 'Next buffer (tab)')
map('n', '<S-TAB>', ':bprevious<CR>', 'Previous buffer (shift-tab)')
map('n', '<leader>bO', helpers.buffers.close_others, 'Close all other buffers (safe)')

-- SUBSECTION: Search and Reload
map('n', '<leader>nh', ':nohl<CR>', '[nh] Clear Search Highlights')
map('n', '<leader>rl', ':source %<CR>', '[R]eload [L]ua File')

-- SUBSECTION: Plugin Managers
map('n', '<leader>lz', ':Lazy<CR>', '[L]a[z]y Plugin Manager')
map('n', '<leader>lm', ':Mason<CR>', '[L]azy [M]ason Plugin Manager')

-- SUBSECTION: Marks
map('n', '<leader>cm', ':delmarks a-zA-Z0-9<CR>', '[C]lear [M]arkers')
map('n', '<leader>ma', ':marks<CR>', 'List all marks')
map('n', '\'m', '`m', 'Go to mark m')

-- SUBSECTION: Window Management
map('n', '<leader>wv', '<C-w>v', 'Split [W]indow [V]ertically')
map('n', '<leader>wh', '<C-w>s', 'Split [W]indow [H]orizontally')
map('n', '<leader>we', '<C-w>=', 'Make [W]indow Splits [E]qual Size')
map('n', '<leader>wx', '<cmd>close<CR>', 'Close current split')
map('n', '<C-Up>', ':resize +2<CR>', 'Increase window height')
map('n', '<C-Down>', ':resize -2<CR>', 'Decrease window height')
map('n', '<C-Left>', ':vertical resize -2<CR>', 'Decrease window width')
map('n', '<C-Right>', ':vertical resize +2<CR>', 'Increase window width')

-- SUBSECTION: Tab Management
map('n', '<leader>to', '<cmd>tabnew<CR>', 'Open new tab')
map('n', '<leader>tx', '<cmd>tabclose<CR>', 'Close current tab')
map('n', '<leader>tn', '<cmd>tabn<CR>', 'Go to next tab')
map('n', '<leader>tp', '<cmd>tabp<CR>', 'Go to previous tab')
map('n', '<leader>tf', '<cmd>tabnew %<CR>', 'Open current buffer in new tab')

-- SUBSECTION: Arrow Key Disabling
map({ 'n', 'v' }, '<left>', '<cmd>echo \'Use h instead\'<CR>', 'Disable left arrow')
map({ 'n', 'v' }, '<right>', '<cmd>echo \'Use l instead\'<CR>', 'Disable right arrow')
map({ 'n', 'v' }, '<up>', '<cmd>echo \'Use k instead\'<CR>', 'Disable up arrow')
map({ 'n', 'v' }, '<down>', '<cmd>echo \'Use j instead\'<CR>', 'Disable down arrow')

-- SUBSECTION: Line Movement
map('n', '<A-j>', ':m .+1<CR>==', 'Move line down')
map('n', '<A-k>', ':m .-2<CR>==', 'Move line up')

-- SUBSECTION: Navigation
map('n', 'H', '^', 'Go to beginning of line')
map('n', 'L', 'g_', 'Go to end of visual line')
map('n', '<C-j>', '10j', 'Move 10 lines down')
map('n', '<C-k>', '10k', 'Move 10 lines up')
map('n', 'W', '5w', 'Jump 5 words forward')
map('n', 'B', '5b', 'Jump 5 words backward')
map('n', '<leader>j', '}', 'Next paragraph')
map('n', '<leader>k', '{', 'Previous paragraph')
map('n', ']b', ']}', 'Next block')
map('n', '[b', '[{', 'Previous block')
map('n', '<C-d>', '<C-d>zz', 'Scroll down and center')
map('n', '<C-u>', '<C-u>zz', 'Scroll up and center')
map('n', 'n', 'nzzzv', 'Next search result and center')
map('n', 'N', 'Nzzzv', 'Prev search result and center')

-- SUBSECTION: Quickfix and Location List
map('n', '<leader>qo', ':copen<CR>', 'Open quickfix list')
map('n', '<leader>qc', ':cclose<CR>', 'Close quickfix list')
map('n', '<leader>qn', ':cnext<CR>', 'Next item in quickfix')
map('n', '<leader>qp', ':cprev<CR>', 'Previous item in quickfix')
map('n', '<leader>lo', ':lopen<CR>', 'Open location list')
map('n', '<leader>lc', ':lclose<CR>', 'Close location list')
map('n', '<leader>ln', ':lnext<CR>', 'Next item in location list')
map('n', '<leader>lp', ':lprev<CR>', 'Previous item in location list')

-- SUBSECTION: Registers
map('n', '<leader>reg', ':registers<CR>', 'Show registers (clipboard, etc.)')

-- SUBSECTION: Lua Execution
map('n', '<leader>lx', ':lua <C-r>=getline(\'.\')<CR><CR>', 'Execute current line as Lua')
map(
  'v',
  '<leader>lx',
  ':<C-u>lua loadstring(table.concat(vim.fn.getline(\'.\', \'.\'), \'\n\'))()<CR>',
  'Execute selection as Lua'
)

-- SUBSECTION: Line Insertion Without Insert Mode
map('n', 'go', 'o<Esc>k', 'Add new line below without entering insert mode')
map('n', 'gO', 'O<Esc>j', 'Add new line above without entering insert mode')

-- SUBSECTION: LSP
map('n', 'gd', vim.lsp.buf.definition, 'Go to Definition')
map('n', 'gD', vim.lsp.buf.declaration, 'Go to Declaration')
map('n', 'gr', vim.lsp.buf.references, 'Find References')
map('n', 'gI', vim.lsp.buf.implementation, 'Go to Implementation')
map('n', '<leader>lD', vim.lsp.buf.type_definition, 'Type Definition')
map('n', '<leader>le', vim.diagnostic.open_float, 'Show Error')
map('n', '<leader>lrn', vim.lsp.buf.rename, 'Rename Symbol')
map('n', '<leader>lca', vim.lsp.buf.code_action, 'Code Action')
map('n', '<leader>lws', vim.lsp.buf.workspace_symbol, 'Workspace Symbols')
map('n', '<leader>lds', vim.lsp.buf.document_symbol, 'Document Symbols')
map('n', '<leader>lF', helpers.lsp.format_code, 'Format Code')
map('n', '<leader>lcl', vim.lsp.codelens.run, 'Run CodeLens')
map('n', '<leader>lcL', vim.lsp.codelens.refresh, 'Refresh CodeLens')
map('n', '<leader>lih', helpers.lsp.toggle_inlay_hints, 'Toggle Inlay Hints')
map('n', '<leader>lR', helpers.lsp.restart, 'Restart LSP and reattach to all buffers')
map('n', '<leader>li', ':LspInfo<CR>', 'Show LSP info')

-- SECTION: Plugins

-- SUBSECTION: AutoSave ../plugins/buffers/auto-save.lua
map('n', '<leader>ua', '<cmd>AutoSaveToggleNotify<CR>', 'Toggle AutoSave [ua]')

-- SUBSECTION: NvimTree
map('n', '<leader>ee', '<cmd>NvimTreeToggle<CR>', 'Toggle File [E]xplor[e]r')
map('n', '<leader>er', '<cmd>NvimTreeRefresh<CR>', 'File [E]xplorer: [R]efresh')
map('n', '<leader>ec', '<cmd>NvimTreeCollapse<CR>', 'File [E]xplorer: [C]ollapse')

-- SUBSECTION: Conform

-- map({ 'n', 'v' }, '<leader>ff', function()
--   conform.format(format_opts)
-- end, '[F]ormat [F]ile or Range')

-- SUBSECTION: ToDo Comments
-- map('n', ']t', function()
--   todo_comments.jump_next()
-- end, 'Next todo comment')

-- map('n', '[t', function()
--   todo_comments.jump_prev()
-- end, 'Previous todo comment')
