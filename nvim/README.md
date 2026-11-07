# Neovim Configuration

This directory contains my minimal, highly functional Neovim configuration, entirely contained within a single `init.lua` file. 

The configuration is designed to be fast and relies heavily on built-in features (like Netrw) while adopting **Doom Emacs-inspired keybindings** via `which-key.nvim`. It also features seamless pane navigation with Tmux.

## 🚀 Features

* **Single File Setup:** Everything is managed inside `init.lua`.
* **Auto-Bootstrapping:** Automatically downloads and installs required plugins (`which-key.nvim` and `vim-tmux-navigator`) on first launch—no external package manager setup required!
* **Doom Emacs Keymap Philosophy:** Uses a mnemonic leader-key sequence (e.g., `<leader>f` for files, `<leader>b` for buffers).
* **Tmux Integration:** Seamless navigation between Neovim splits and Tmux panes using `Ctrl + hjkl`.
* **Quality of Life:** 
  * Centered scrolling and search results.
  * Dragging visual blocks up and down with auto-indentation.
  * System clipboard integration.
  * Remembers the last cursor position when reopening a file.

## 📦 Installation

Simply drop the `init.lua` file into your Neovim configuration directory:

**Linux/macOS:**
```bash
mkdir -p ~/.config/nvim
cp init.lua ~/.config/nvim/init.lua
```

When you open Neovim for the first time, it will briefly clone the necessary standalone plugins into your data directory and immediately load them.

## ⌨️ Keybindings

**Leader Key:** `<Space>`  
**Local Leader:** `<Space>`

### 📁 File Operations (`<leader>f`)
| Keybinding | Action |
| :--- | :--- |
| `<leader>ff` | Find file in path (`:find *`) |
| `<leader>fs` | Save file |
| `<leader>fS` | Save all files |
| `<leader>fr` | Open recent files |
| `<leader>fR` | Revert buffer to saved state |
| `<leader>fp` | Open config (`init.lua`) |

### 📑 Buffer Operations (`<leader>b`)
| Keybinding | Action |
| :--- | :--- |
| `<leader>bb` | Switch buffer |
| `<leader>bn` | Next buffer |
| `<leader>bp` | Previous buffer |
| `<leader>bd` | Delete current buffer |
| `<leader>bD` | Force delete current buffer |
| `<leader>br` | Alternate/Last active buffer |
| `<leader><space>`| Quick find/switch buffer |

### 🪟 Window Operations (`<leader>w`)
| Keybinding | Action |
| :--- | :--- |
| `<leader>ws` | Horizontal split |
| `<leader>wv` | Vertical split |
| `<leader>wc` | Close current window |
| `<leader>wo` | Close all other windows |
| `<leader>w=` | Balance window sizes |
| `<leader>w[hjkl]`| Focus left/down/up/right window |

*Note: Window navigation is also bound directly to `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`, and `<C-\>` for seamless movement across Neovim splits and Tmux panes.*

### 🚀 Open / Toggle (`<leader>o`)
| Keybinding | Action |
| :--- | :--- |
| `<leader>op` | Open file tree (Netrw) |
| `<leader>ot` | Open a bottom terminal split |

### 🚪 Quit & Session (`<leader>q`)
| Keybinding | Action |
| :--- | :--- |
| `<leader>qq` | Quit Neovim |
| `<leader>qQ` | Force quit all |
| `<leader>qr` | Reload `init.lua` config |

### 🛠️ General Editing & Movement
| Keybinding | Mode | Action |
| :--- | :--- | :--- |
| `J` / `K` | Visual | Move selected lines down/up (auto-indents) |
| `<C-d>` / `<C-u>`| Normal | Scroll half-page down/up and center cursor |
| `n` / `N` | Normal | Next/Previous search match (centers cursor) |
| `<leader>p` | Visual | Paste over selection *without* overwriting the clipboard |
| `<Esc>` | Normal | Clear search highlight |
| `<Esc><Esc>` | Terminal | Exit terminal input mode |

## ⚙️ Core Editor Settings

* **Indentation:** 2 spaces, expand tabs, smart indent.
* **UI:** True color support, relative line numbers (with absolute current line), sign column always on.
* **Search:** Case-insensitive by default, switches to case-sensitive if a capital letter is typed (`smartcase`).
* **Filesystem:** Undofile is enabled for persistent undo history. Swap and backup files are disabled. 