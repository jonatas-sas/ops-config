--[[
Heuristic-based classification of PHP files into specialized subtypes.

This module is designed to classify PHP files into more meaningful filetypes
based on their content and naming patterns. It helps tools like formatters,
linters, LSPs, and custom behavior in Neovim identify the nature of a PHP file
(e.g., config file, template, or migration script).

## Supported filetypes:
- `php.config`             → Configuration files that return arrays or closures.
- `php.template`           → View files mixing PHP and HTML, without logic.
- `php.yii.migration`      → Yii migration classes extending `Migration`.
- `php.laravel.migration`  → Laravel migration files using `Illuminate\Database\Migrations`.

## Design principles:
- Short-circuit evaluation: stop as early as possible to avoid performance impact.
- Do not rely exclusively on file path. Content is authoritative.
- Use `ripgrep` (`rg`) for fast content inspection.

--]]

local M = {}

--- Checks for any forbidden PHP constructs that indicate the file is logic-heavy.
--- These include namespace, class, function, trait, and interface definitions.
--- @param path string: Absolute path to the PHP file
--- @return boolean: True if any forbidden structure (namespace, class, etc.) is found
function M.has_forbidden_constructs(path)
  local patterns = { '^namespace ', 'class ', 'function ', 'trait ', 'interface ' }
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
function M.has_top_level_return(path)
  local result = vim.fn.system({ 'rg', '^return ', path })
  return result ~= ''
end

--- Checks for signs the file is a PHP+HTML template:
--- short echo tags, HTML tags, or common inline output markers.
--- @param path string
--- @return boolean: True if HTML or short echo tags are found
function M.has_template_indicators(path)
  local result = vim.fn.system({ 'rg', '<?=|<\\?php echo|<html|<body|<!DOCTYPE', path })
  return result ~= ''
end

--- Determines whether the file appears to be a Yii migration.
--- This is inferred by checking if the class extends a class named Migration.
--- @param path string
--- @return boolean: True if file appears to be a Yii migration class
function M.is_yii_migration(path)
  local result = vim.fn.system({ 'rg', 'extends\\s+Migration', path })
  return result:match('yii') ~= nil or result:match('Migration') ~= nil
end

--- Determines whether the file uses Laravel migration base namespace.
--- Looks for `Illuminate\Database\Migrations` usage.
--- @param path string
--- @return boolean: True if file appears to be a Laravel migration
function M.is_laravel_migration(path)
  local result = vim.fn.system({ 'rg', 'Illuminate\\\\Database\\\\Migrations', path })
  return result ~= ''
end

--- Determines if the file should be treated as a config file.
--- Requires no executable structure (class, function, etc.) and top-level return.
--- File name or path must suggest configuration.
--- @param path string
--- @param filename string
--- @return boolean: True if file satisfies rules for config file
function M.is_php_config(path, filename)
  if M.has_forbidden_constructs(path) then
    return false
  end

  if not M.has_top_level_return(path) then
    return false
  end

  local is_config_named = filename == 'config.php' or filename:match('params%.php$')
  local is_config_path = path:match('[^%w]config[^%w]')

  print('is_config_named', is_config_named)
  return is_config_named or is_config_path
end

--- Determines if the file is a PHP+HTML template.
--- It must not have forbidden structures and must show clear visual output markers.
--- @param path string
--- @return boolean: True if file appears to be a PHP+HTML template
function M.is_php_template(path)
  if M.has_forbidden_constructs(path) then
    return false
  end

  return M.has_template_indicators(path)
end

return M
