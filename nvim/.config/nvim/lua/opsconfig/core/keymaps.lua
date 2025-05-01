-- General Keymaps -------------------
vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode with jk' })
vim.keymap.set('i', 'jj', '<ESC>', { desc = 'Exit insert mode with jj' })
vim.keymap.set('i', 'kk', '<ESC>', { desc = 'Exit insert mode with kk' })
vim.keymap.set('i', ':w', '<ESC>:w<CR>', { desc = 'Exit insert and save' })
vim.keymap.set('i', ':W', '<ESC>:w<CR>', { desc = 'Exit insert and save' })

vim.keymap.set('n', '<leader>bo', ':%bd|e#|bd#<CR>', { desc = 'Close all Buffers except Current' })

-- clear search highlights
vim.keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })

-- Reload Lua File
vim.keymap.set('n', '<leader>rl', ':source %<CR>', { desc = '[R]eload [L]ua File' })

-- Lazy and Mason
vim.keymap.set('n', '<leader>lz', ':Lazy<CR>', { desc = '[L]a[z]y Plugin Manager' })
vim.keymap.set('n', '<leader>lm', ':Mason<CR>', { desc = '[L]azy [M]ason Plugin Manager' })

-- Markers
vim.keymap.set('n', '<leader>cm', ':delmarks a-zA-Z0-9<cr>', { desc = '[C]lear [M]arkers' })

-- window management
vim.keymap.set('n', '<leader>wv', '<C-w>v', { desc = 'Split [W]indow [V]ertically' }) -- split window vertically
vim.keymap.set('n', '<leader>wh', '<C-w>s', { desc = 'Split [W]indow [H]orizontally' }) -- split window horizontally
vim.keymap.set('n', '<leader>we', '<C-w>=', { desc = 'Make [W]window Splits [E]qual Size' }) -- make split windows equal width & height
vim.keymap.set('n', '<leader>wx', '<cmd>close<CR>', { desc = 'Close current split' }) -- close current split window

-- tabs management
vim.keymap.set('n', '<leader>to', '<cmd>tabnew<CR>', { desc = 'Open new tab' }) -- open new tab
vim.keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = 'Close current tab' }) -- close current tab
vim.keymap.set('n', '<leader>tn', '<cmd>tabn<CR>', { desc = 'Go to next tab' }) --  go to next tab
vim.keymap.set('n', '<leader>tp', '<cmd>tabp<CR>', { desc = 'Go to previous tab' }) --  go to previous tab
vim.keymap.set('n', '<leader>tf', '<cmd>tabnew %<CR>', { desc = 'Open current buffer in new tab' }) --  move current buffer to new tab

-- Disable arrow keys in normal and visual modes
vim.keymap.set({ 'n', 'v' }, '<left>', '<cmd>echo "Please only use h to move to left."<CR>')
vim.keymap.set({ 'n', 'v' }, '<right>', '<cmd>echo "Please only use l to move to right."<CR>')
vim.keymap.set({ 'n', 'v' }, '<up>', '<cmd>echo "Please only use k to move up."<CR>')
vim.keymap.set({ 'n', 'v' }, '<down>', '<cmd>echo "Please only use j to move down."<CR>')
