local M = {}

M.set_find_files = function(keys, desc, title, opts, mode, buffer)
  mode = mode or 'n'
  buffer = buffer or nil
  opts = opts or {}
  title = title or 'Find Files'

  local keymap_opts = {
    desc = desc,
  }

  if buffer then
    keymap_opts.buffer = buffer
  end

  vim.keymap.set(mode, keys, function()
    local builtin = require('telescope.builtin')
    local config = vim.g.opsconfig.global

    opts.prompt_tile = title
    opts.follow = config.files.follow_symlinks
    opts.hidden = config.files.hidden_files
    opts.no_ignore = config.files.git_no_ignore
    opts.no_ignore_parent = config.files.git_no_ignore

    builtin.find_files(opts)
  end, keymap_opts)
end

M.set_grep = function(keys, desc, title, opts, mode, buffer)
  mode = mode or 'n'
  buffer = buffer or nil
  opts = opts or {}
  title = title or 'Live Grep'

  local keymap_opts = {
    desc = desc,
  }

  if buffer then
    keymap_opts.buffer = buffer
  end

  vim.keymap.set(mode, keys, function()
    local builtin = require('telescope.builtin')

    opts.prompt_tile = title

    builtin.live_grep(opts)
  end, keymap_opts)
end

M.set_lsp = function(keys, func, desc, buffer, mode)
  mode = mode or 'n'
  buffer = buffer or nil

  local opts = {
    desc = 'LSP:' .. desc,
  }

  if buffer then
    opts.buffer = buffer
  end

  vim.keymap.set(mode, keys, func, opts)
end

M.set_fn = function(keys, func, desc, buffer, mode)
  mode = mode or 'n'
  buffer = buffer or nil

  local opts = {
    desc = desc,
  }

  if buffer then
    opts.buffer = buffer
  end

  vim.keymap.set(mode, keys, func, opts)
end

return M
