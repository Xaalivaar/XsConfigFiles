-- Leader key (Space)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core UI & Behavior
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Relative line numbers for fast jumps
vim.opt.mouse = "a"            -- Enable mouse support
vim.opt.ignorecase = true      -- Case-insensitive search unless capital used
vim.opt.smartcase = true       -- Smart case search
vim.opt.termguicolors = true   -- True color support
vim.opt.signcolumn = "yes"     -- Always show sign column (prevents text shift)
vim.opt.updatetime = 250       -- Faster completion/diagnostics
vim.opt.timeoutlen = 300       -- Fast keymap sequence timeout

-- Indentation
vim.opt.expandtab = true       -- Convert tabs to spaces
vim.opt.shiftwidth = 2         -- 2 spaces for indent width
vim.opt.tabstop = 2            -- 2 spaces for tab width
vim.opt.smartindent = true     -- Smart auto-indenting

-- Backup & History
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true        -- Persistent undo across sessions

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Basic Keymaps
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open Netrw file explorer" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
vim.keymap.set("n", "<C-d>", "<C-d>z>", { desc = "Half page down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>z>", { desc = "Half page up and center" })

