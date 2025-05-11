local M = {}

-- SECTION: FileTypes

M.ft = {}

--- Checks for any forbidden PHP constructs that indicate the file is logic-heavy.
--- These include namespace, class, function, trait, and interface definitions.
--- @param path string: Absolute path to the PHP file
--- @return boolean: True if any forbidden structure (namespace, class, etc.) is found
local function has_forbidden_constructs(path)
  local patterns = {
    '^namespace ',
    'class ',
    'public function ',
    'protected function ',
    'trait ',
    'interface ',
  }

  for _, pat in ipairs(patterns) do
    local result = vim.fn.system({ 'rg', pat, path })
    if result ~= '' then
      return true
    end
  end
  return false
end

--- Checks if the file has a top-level return statement, suggesting it's returning a data structure.
--- @param path string
--- @return boolean: True if file has top-level return
local function has_top_level_return(path)
  local result = vim.fn.system({ 'rg', '^return ', path })

  return result ~= ''
end

--- Checks for signs the file is a PHP+HTML template:
--- short echo tags, HTML tags, or common inline output markers.
--- @param path string
---
--- @return boolean: True if HTML or short echo tags are found
local function has_template_indicators(path)
  local result = vim.fn.system({ 'rg', '<?=|<\\?php echo|<html|<body|<!DOCTYPE', path })

  return result ~= ''
end

--- Determines whether the file appears to be a Yii migration.
--- This is inferred by checking if the class extends a class named Migration.
--- @param path string
---
--- @return boolean: True if file appears to be a Yii migration class
function M.ft.is_yii_migration(path)
  local result = vim.fn.system({ 'rg', 'extends\\s+Migration', path })

  return result:match('yii') ~= nil or result:match('Migration') ~= nil
end

--- Determines if the file should be treated as a config file.
--- Requires no executable structure (class, function, etc.) and top-level return.
--- File name or path must suggest configuration.
--- @param path string
--- @param filename string
---
--- @return boolean: True if file satisfies rules for config file
function M.ft.is_php_config(path, filename)
  if has_forbidden_constructs(path) then
    return false
  end

  if has_top_level_return(path) then
    return true
  end

  local is_config_named = filename == 'config.php' or filename:match('params%.php$')
  local is_config_path = false

  for segment in path:gmatch('[^/]+') do
    if segment == 'config' then
      is_config_path = true

      break
    end
  end

  return is_config_named or is_config_path
end

--- Determines if the file is a PHP+HTML template.
--- It must not have forbidden structures and must show clear visual output markers.
--- @param path string
--- @param filename string
---
--- @return boolean: True if file appears to be a PHP+HTML template
function M.ft.is_php_template(path, filename)
  if has_forbidden_constructs(path) then
    return false
  end

  if M.ft.is_php_config(path, filename) then
    return false
  end

  return has_template_indicators(path)
end

-- SECTION: LSP

M.lsp = {}
---
--- Starts Phpactor LSP for a given buffer if it's not already attached.
---
--- @param bufnr integer Buffer number to attach the LSP to.
--- @param name string The LSP client name.
--- @param init_options table Initialization options to be passed to Phpactor.
---
--- @return nil
M.lsp.load_phpactor = function(bufnr, name, init_options)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  for _, client in ipairs(clients) do
    if client.name == 'phpactor' then
      return
    end
  end

  local capabilities, flags = require('opsconfig.plugins.lsp.config.lsp').default_config()

  vim.lsp.start({
    name = name,

    cmd = { 'phpactor', 'language-server' },

    root_dir = vim.fn.getcwd(),

    settings = {},

    init_options = init_options,

    capabilities = capabilities,

    flags = flags,

    handlers = {
      ['textDocument/publishDiagnostics'] = function(_, result, ctx, config)
        local client = vim.lsp.get_client_by_id(ctx.client_id)

        if client and client.name == name and result and result.diagnostics then
          result.diagnostics = vim.tbl_filter(function(diagnostic)
            return not diagnostic.message:match('^Namespace should probably be')
          end, result.diagnostics)
        end

        vim.lsp.handlers['textDocument/publishDiagnostics'](_, result, ctx, config)
      end,
    },
  })
end

return M
