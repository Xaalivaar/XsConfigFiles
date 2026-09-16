# Doom-flavored Zed configuration

A small, reproducible Zed setup aimed at keeping the parts of Doom Emacs that matter most in day-to-day work:

- Vim modal editing
- `SPC` leader-key workflow
- Which-Key discovery
- project/file/buffer navigation
- language-aware `SPC m ...` commands
- LaTeX editing and compilation
- Markdown preview and executable code blocks
- C editing, formatting, building, and running
- Python `# %%` cells with Zed's Jupyter-backed REPL

The configuration is intentionally small rather than trying to clone Doom Emacs wholesale.

## Files

This setup consists of three main Zed configuration files:

```text
~/.config/zed/
├── settings.json
├── keymap.json
└── tasks.json
```

### `settings.json`

Configures editor behavior and language-specific preferences, including:

- Vim mode
- Which-Key with a 500 ms delay
- relative line numbers
- One Light / One Dark theme following the system theme
- 88-column default preferred line length
- 80-column preferred line length for C, Markdown, and LaTeX
- format-on-save for C and Python
- manual formatting for Markdown
- inlay hints
- telemetry disabled

### `keymap.json`

Provides the Doom-style leader hierarchy and language-specific major-mode bindings.

### `tasks.json`

Defines reusable tasks for:

- LaTeX build with `latexmk`
- LaTeX auxiliary-file cleanup
- building the current C file with `cc`
- running the resulting C executable

> `tasks.json` currently also contains Zed's example task at the top. It can be deleted if it is not useful.

## Requirements

The exact package names depend on your Linux distribution, but the setup expects the following tools to be available on `PATH`:

```text
Zed
Git
Python 3
python3-venv
ipykernel
clang / clangd / clang-format (recommended for C)
cc                      (used by the current C build task)
TeX Live
latexmk
Zathura                  (used here as the PDF viewer)
```

For Debian/Ubuntu-like systems, a typical base installation is along the lines of:

```bash
sudo apt install \
    git \
    python3 \
    python3-venv \
    clang \
    clangd \
    clang-format \
    texlive-full \
    latexmk \
    zathura
```

Install Python notebook support inside each project environment as needed:

```bash
python -m pip install ipykernel
```

For scientific Python work, for example:

```bash
python -m pip install numpy matplotlib pandas ipykernel
```

## Installation

Back up an existing Zed configuration first if necessary:

```bash
mkdir -p ~/.config/zed
cp -a ~/.config/zed ~/.config/zed.backup
```

Then copy the three files into Zed's configuration directory:

```bash
cp settings.json ~/.config/zed/settings.json
cp keymap.json  ~/.config/zed/keymap.json
cp tasks.json   ~/.config/zed/tasks.json
```

Restart Zed or reload the configuration.

## Leader-key layout

The main leader is `SPC`, used in Vim normal mode.

```text
SPC f ...    files
SPC p ...    project
SPC b ...    buffers / tabs
SPC s ...    search / symbols
SPC c ...    code / tasks / diagnostics
SPC g ...    Git
SPC o ...    panels
SPC w ...    windows / panes
SPC m ...    language-specific commands
SPC SPC      command palette
```

The bare `SPC` mapping is intentionally disabled as a normal Vim command so that the leader tree and Which-Key behave cleanly.

## Core keybindings

### Files

```text
SPC f f    file finder
SPC f s    save current file
SPC f S    save all files
```

### Project

```text
SPC p f    project file finder
SPC p p    project panel
SPC p s    project search
```

### Buffers / tabs

```text
SPC b b    tab switcher
SPC b B    all-tab switcher
SPC b n    next tab/item
SPC b p    previous tab/item
SPC b l    alternate file
SPC b k    close active item
```

### Search and symbols

```text
SPC s p    project search
SPC s s    current-buffer search
SPC s i    file outline
SPC s I    project symbols
```

### Code and diagnostics

```text
SPC c a    code actions
SPC c r    rename symbol
SPC c f    format buffer
SPC c x    diagnostics
SPC c c    choose/spawn task
SPC c C    rerun task
```

### Git and panels

```text
SPC g g    Git panel
SPC o p    project panel
SPC o t    terminal panel
```

### Windows / panes

```text
SPC w h    focus pane left
SPC w j    focus pane down
SPC w k    focus pane up
SPC w l    focus pane right

SPC w H    swap pane left
SPC w J    swap pane down
SPC w K    swap pane up
SPC w L    swap pane right

SPC w m    toggle editor zoom
```

When a dock is focused, standard Vim-style pane movement is also available:

```text
Ctrl-w h
Ctrl-w j
Ctrl-w k
Ctrl-w l
```

### Insert-mode escape

```text
j k        return to normal mode
```

## Which-Key

Which-Key is enabled in `settings.json` with a 500 ms delay.

Press a prefix such as:

```text
SPC
SPC b
SPC w
SPC m
```

and pause briefly to discover the available continuations.

## Language workflows

## LaTeX

The LaTeX bindings are active for `.tex` files.

```text
SPC m c    build current document
SPC m k    clean auxiliary files
```

The build task runs:

```bash
latexmk -pdf -interaction=nonstopmode -synctex=1 <current-file>
```

The clean task runs:

```bash
latexmk -c <current-file>
```

The current workflow uses Zathura to view the generated PDF.

## C

The C bindings are active for `.c` files.

```text
SPC m b    build current file
SPC m r    run compiled program
SPC m f    format current file
```

The build task currently compiles the active file with:

```bash
cc -std=c17 -Wall -Wextra -Wpedantic -g source.c -o source
```

For larger projects, replace the single-file build task with the project's normal build system (`make`, CMake, Ninja, Meson, etc.).

For good `clangd` support in non-trivial projects, provide a compilation database such as:

```text
compile_commands.json
```

A project-local `.clang-format` is also recommended if consistent formatting matters.

## Python

Python work uses ordinary `.py` files with `# %%` cells rather than `.ipynb` notebooks.

Example:

```python
# %% imports
import numpy as np
import matplotlib.pyplot as plt

# %% computation
x = np.linspace(0, 2 * np.pi, 200)
y = np.sin(x)
y[:5]

# %% plot
plt.plot(x, y)
plt.show()
```

Major-mode bindings:

```text
SPC m r    run current cell and advance
SPC m R    run current cell in place
SPC m c    clear all REPL output
SPC m C    clear current-cell output
SPC m s    show REPL sessions
SPC m k    restart kernel
SPC m i    interrupt running code
SPC m f    format current file
```

Zed's normal REPL shortcut can still be used as a fallback:

```text
Ctrl-Shift-Enter
```

A typical project environment is:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -U pip
python -m pip install ipykernel numpy matplotlib pandas
zed .
```

If Zed already detects the active or project-local virtual environment correctly, no manual toolchain selection is necessary.

Do not copy `.venv/` between machines. Recreate it from a dependency file such as `requirements.txt` or `pyproject.toml`.

## Markdown

Markdown is used primarily for prose, notes, project documentation, and lightweight literate programming.

Major-mode bindings:

```text
SPC m p    open Markdown preview
SPC m P    open preview beside source
SPC m r    run executable fenced block / selection
SPC m R    run without advancing
SPC m c    clear REPL outputs
SPC m f    format manually
```

Example executable block:

````markdown
```python
import numpy as np

x = np.arange(5)
x ** 2
```
````

The intended division of labor is:

```text
.tex          formal documents / papers
.md           notes / explanations / documentation
.py + # %%    interactive computation
.c            C source
```

## Recommended project-local files

These are not part of the global Zed configuration, but are useful for reproducibility inside individual projects:

```text
.clang-format
.clangd
compile_commands.json
pyproject.toml
requirements.txt
```

Example Python configuration:

```toml
[tool.ruff]
line-length = 88

[tool.basedpyright]
typeCheckingMode = "standard"
```

Example C formatting configuration:

```yaml
BasedOnStyle: LLVM
IndentWidth: 4
ColumnLimit: 80
PointerAlignment: Right
```

## Reproducing the setup on another machine

1. Install Zed.
2. Install the external tools listed under **Requirements**.
3. Copy `settings.json`, `keymap.json`, and `tasks.json` into `~/.config/zed/`.
4. Install any desired Zed language extensions, especially LaTeX support if it is not already available.
5. Recreate project Python virtual environments instead of copying them.
6. Open a project in Zed and verify the four workflows:

```text
Python      # %% cell executes inline
Markdown    preview opens and fenced Python executes
LaTeX       SPC m c builds a PDF
C           SPC m b builds and SPC m r runs
```

## Dotfiles setup

For a more permanent setup, keep these files in a dotfiles repository and symlink them into Zed's configuration directory.

Example layout:

```text
~/dotfiles/
└── zed/
    ├── settings.json
    ├── keymap.json
    ├── tasks.json
    └── README.md
```

Example symlinks:

```bash
mkdir -p ~/.config/zed
ln -sf ~/dotfiles/zed/settings.json ~/.config/zed/settings.json
ln -sf ~/dotfiles/zed/keymap.json  ~/.config/zed/keymap.json
ln -sf ~/dotfiles/zed/tasks.json   ~/.config/zed/tasks.json
```

## Philosophy

This configuration keeps Zed native where Zed is already good, and adds Doom-style structure only where it improves muscle memory and discoverability:

```text
Vim motions     editing and navigation
SPC ...         editor / project commands
SPC m ...       language-specific commands
Which-Key       discoverability
Zed REPL        notebook-like execution without .ipynb
Tasks           simple compilation workflows
```

The goal is not to reproduce every Doom Emacs binding. It is to keep a compact, memorable workflow that remains easy to maintain as Zed evolves.
