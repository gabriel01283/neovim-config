# NEOVIM CONFIG

<div align="center">

### `> A personalized development environment_`

**Fast • Minimal • Keyboard-driven**

![Neovim](https://img.shields.io/badge/Neovim-0.11%2B-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-Configuration-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-Open%20Source-181717?style=for-the-badge&logo=github&logoColor=white)

---

*My personal Neovim setup, built for productivity, customization and learning.*

</div>

## ✦ Overview

This repository contains my personal Neovim configuration, written in Lua and built around a lightweight, customizable development workflow.

The goal is to create a comfortable programming environment with modern editor features while keeping the speed and flexibility of Neovim.

## ✦ Features

- File explorer with icons and Git integration
- Language Server Protocol (LSP) support
- Intelligent code completion
- Syntax highlighting with Treesitter
- Integrated terminal with custom shortcuts
- Personalized statusline
- Plugin management with lazy.nvim
- Custom colorscheme

## ✦ Tech Stack

| Component | Technology |
|---|---|
| Editor | Neovim |
| Configuration | Lua |
| Plugin manager | lazy.nvim |
| Theme | Miasma |
| File explorer | nvim-tree |
| Statusline | Heirline |
| Autocomplete | nvim-cmp |
| LSP management | Mason |
| Syntax highlighting | Treesitter |
| Font | JetBrainsMono Nerd Font |

## ✦ Keyboard Shortcuts

| Shortcut | Action |
|---|---|
| `Ctrl + B` | Toggle file explorer |
| `Ctrl + X` | Toggle integrated terminal |
| `Space + E` | Focus file explorer |
| `u` | Undo |
| `Ctrl + R` | Redo |

### File Explorer

| Key | Action |
|---|---|
| `a` | Create file or directory |
| `d` | Delete |
| `r` | Rename |
| `Enter` | Open file |

## ✦ Project Structure

```text
~/.config/nvim/
├── init.lua
├── lazy-lock.json
├── .gitignore
└── README.md
```

## ✦ Installation

**Requirements**

- Neovim 0.11+
- Git
- A Nerd Font
- Language-specific tools for the LSP servers you want to use

Clone the repository:

```bash
git clone https://github.com/gabriel01283/neovim-config.git ~/.config/nvim
```

Start Neovim:

```bash
nvim
```

The plugin manager will install the configured plugins when initialized.

> Back up your existing `~/.config/nvim` directory before cloning if you already have a configuration.

## ✦ Philosophy

> Make the terminal feel like home.

This configuration is an ongoing personal project, focused on learning, experimentation and creating an efficient development environment.

---

<div align="center">

**Made with Lua, Neovim and a lot of patience.**

`</>` **gabriel01283**

</div>
