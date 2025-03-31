# OpsConfig

**OpsConfig** is a curated and modular dotfiles collection built for operational excellence, focusing on maintainability, extensibility, and productivity — especially for developers, sysadmins, and power users who rely heavily on terminal and Neovim workflows.

> ⚠️ This repository does not accept contributions. It is tailored for personal use and internal deployment.
>
> 🛑 **Disclaimer**: This configuration is designed for my **personal use**. I **do not recommend** installing it arbitrarily on your system unless you understand exactly what it does.

---

## 🧩 Overview

OpsConfig is structured to provide:

- A modular Neovim configuration system
- Optimized Bash shell experience
- Seamless integration with tools like `tmux`, `Taskwarrior`, `Git`, and language servers
- Ready-to-use plugins for remote file sync, debugging, LSP, testing, AI assistance, and more

---

## ⚙️ Installation

To configure your environment using the dotfiles from this repository, run:

```bash
curl -fsSL https://raw.githubusercontent.com/jonatas-sas/OpsConfig/main/install | bash
```

> ⚠️ **Warning**: This script will **overwrite** existing configurations (e.g., `.bashrc`, `.bash_logout`, Neovim config).  
> It's strongly recommended to **backup your current settings** before proceeding.

---

## 📁 Structure

```txt
opsconfig/
├── install               # Setup entrypoint (bootstrap script)
├── bash/                 # Bash dotfiles (.bashrc, .bash_logout, etc.)
├── nvim/                 # Neovim configurations
│   └── .config/nvim/
│       ├── init.lua
│       ├── lazy-lock.json
│       ├── lua/opsconfig/
│       │   ├── core/          # Core options, keymaps, file utils
│       │   ├── config/        # General configs, plugin list, servers, etc.
│       │   ├── plugins/       # Plugins by category
│       │   ├── helpers/       # Helper modules
└── storage/              # Shared ignore-enabled directory for runtime or backup storage
```

---

## 🧠 Features

### 🔧 Neovim

- **Plugin Management**: [`lazy.nvim`](https://github.com/folke/lazy.nvim)
- **UI Enhancements**: `noice.nvim`, `lualine.nvim`, `alpha.nvim`, `tokyonight`, `catppuccin`
- **File Navigation**: `nvim-tree`, `oil.nvim`, `telescope.nvim`, `harpoon`
- **LSP & Formatters**: `nvim-lspconfig`, `phpactor`, `gopls`, `conform.nvim`
- **Testing**: `neotest`, `vim-test`
- **Terminal Integration**: `toggleterm.nvim`
- **Sessions**: `auto-session`
- **Remote Sync**: custom transfer tool
- **Text Manipulation**: `surround`, `substitute`, `comment`, `mini.align`, `todo-comments`
- **Debugging**: `nvim-dap` with language support
- **Snippets**: `LuaSnip`
- **Clipboard**: `osc52`
- **Tasks**: Native integration with `Taskwarrior`, `ntask.nvim`, `wiki`
- **AI Tools**: `copilot`, `codeium`, `chatgpt.nvim`
- **Security**: `vim-suda` (read/write as root)

### 🖥️ Shell

- Custom `.bashrc`, `.bash_custom`, `.bash_logout`
- Prompt enhancements (`.bash_ps1`)
- Git-aware shell configurations

---

## 🔌 Active Plugins

This config includes an extensive set of plugins, organized by category. Below is a snapshot of what’s available (only shown if enabled in `plugins.lua`):

> You can find plugin definitions under:  
> `nvim/.config/nvim/lua/opsconfig/plugins/**`

| Category         | Plugins                                                             |
| ---------------- | ------------------------------------------------------------------- |
| UI               | `lualine`, `noice`, `dressing`, `alpha`, `tokyonight`, `catppuccin` |
| Navigation       | `telescope`, `nvim-tree`, `harpoon`, `oil`                          |
| LSP & Formatting | `nvim-lspconfig`, `phpactor`, `gopls`, `conform`, `lint`, `mason`   |
| Editing          | `comment`, `todo-comments`, `mini.align`, `surround`, `substitute`  |
| AI Assistance    | `copilot`, `codeium`, `chatgpt.nvim`                                |
| Tasks            | `ntask.nvim`, `overseer`, `wiki`                                    |
| Testing          | `neotest`, `vim-test`                                               |
| Debugging        | `nvim-dap`, `dap-php`, `dap-go`                                     |
| Terminal         | `toggleterm`, `tmux-navigator`                                      |
| Git              | `lazygit`, `gitsigns`                                               |
| Clipboard        | `osc52`                                                             |
| Security         | `vim-suda`                                                          |
| UI Enhancements  | `which-key`, `devicons`, `indent-blankline`                         |
| Remote Tools     | `transfer`                                                          |
| Folding          | `nvim-ufo`                                                          |
| Snippets         | `LuaSnip`, custom snippet sources                                   |
| Dev Utilities    | `trouble`, `plenary`, `lua-lazydev`                                 |

---

## 📚 Plugin Documentation (Optional)

If you'd like to include keybindings, commands, or documentation for a specific plugin, just let me know!  
For example:

- 🔁 [`substitute.nvim`](https://github.com/gbprod/substitute.nvim): enhanced text replacement
- 🐞 [`nvim-dap`](https://github.com/mfussenegger/nvim-dap): debugging framework
- 🔍 [`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim): fuzzy finder

---

## 🚫 No Contributions Policy

This repository is maintained privately for personal and internal use only. Issues, pull requests, or external contributions will not be accepted.

---

## 📜 License

This repository is licensed for personal use only. See `LICENSE` if available, or contact the author for more details.

---
