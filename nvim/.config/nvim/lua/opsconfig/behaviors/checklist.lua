vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    local wk = require('which-key')

    wk.add({
      {
        '<leader>cb',
        'I- [ ] <Esc>',
        desc = '[C]hecklist: Insert [B]ox',
        icon = { icon = '', color = 'red' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>cc',
        [[:s/- \[ \]/- [x]/g<CR>]],
        desc = '[C]hecklist: [C]omplete task(s)',
        icon = { icon = '', color = 'cyan' },
        mode = { 'n', 'v' },
        noremap = true,
        silent = true,
      },
      {
        '<leader>cu',
        [[:s/- \[x\]/- [ ]/<CR>]],
        desc = '[C]hecklist: [U]nmark task',
        icon = { icon = '', color = 'red' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>ct',
        [[:s/\v\[.\]/\=submatch(0)=='[x]' ? '[ ]' : '[x]'/<CR>]],
        desc = '[C]hecklist: [T]oggle [ ] ⇄ [x]',
        icon = { icon = '', color = 'blue' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
      {
        '<leader>cd',
        [[:g/^- \[x\]/d<CR>]],
        desc = '[C]hecklist: [D]elete completed',
        icon = { icon = '', color = 'green' },
        mode = 'n',
        noremap = true,
        silent = true,
      },
    })
  end,
})
