# AGENTS.md

## Project Overview

This repository is a personal Neovim configuration based on the [NvChad starter](https://github.com/NvChad/starter).

- **Language:** Lua
- **Core framework:** NvChad (`NvChad/NvChad`, branch `v2.5`)
- **Plugin manager:** `lazy.nvim`
- **Key config areas:** plugin specs, keymaps, options, LSP, formatting

There is no application build output in the traditional sense; this repo is runtime editor configuration.

## Repository Layout

- `init.lua` — entry point; bootstraps `lazy.nvim` and loads config modules
- `lua/chadrc.lua` — NvChad UI/theme overrides
- `lua/options.lua` — editor options
- `lua/mappings.lua` — custom keymaps and autocmds
- `lua/plugins/init.lua` — plugin specs managed by `lazy.nvim`
- `lua/configs/lazy.lua` — lazy.nvim behavior/performance settings
- `lua/configs/lspconfig.lua` — LSP setup
- `lua/configs/conform.lua` — formatter setup (`stylua` for Lua)
- `lua/custom/init.lua` — custom autocmd behavior
- `lazy-lock.json` — pinned plugin versions; commit this when plugin versions change

## Setup Commands

### Initial install

```bash
git clone git@github.com:duckworth/nvim-settings.git ~/.config/nvim
```

### Start Neovim with this config

```bash
nvim
```

### Sync/update plugins (non-interactive)

```bash
nvim --headless '+Lazy! sync' '+qa'
```

### Install Mason tools (interactive, one-time after plugin install)

Inside Neovim:

```vim
:MasonInstallAll
```

### Optional local prerequisites

```bash
brew install --cask font-hack-nerd-font
```

## Development Workflow

1. Edit Lua config files under `lua/` and/or `init.lua`.
2. For plugin list or version changes, update `lua/plugins/init.lua`, then run:

   ```bash
   nvim --headless '+Lazy! sync' '+qa'
   ```

3. Commit `lazy-lock.json` when plugin versions change.
4. Re-open Neovim to validate behavior interactively.

## Testing Instructions

This repository currently has **no unit/integration test suite** and no CI workflows checked in.

Use these verification commands before submitting changes:

### Smoke test config load

```bash
nvim --headless '+qa'
```

### Run Neovim health checks

```bash
nvim --headless '+checkhealth' '+qa'
```

### Validate plugin resolution and lockfile consistency

```bash
nvim --headless '+Lazy! sync' '+qa'
```

### Optional Lua formatting check (if `stylua` is installed globally)

```bash
stylua --check .
```

## Code Style Guidelines

### Lua formatting

Follow `.stylua.toml`:

- 2-space indentation
- max line width 120
- Unix line endings
- prefer double quotes when possible

### Project conventions

- Keep modules small and place them under `lua/<area>/...`.
- Use idiomatic Neovim Lua patterns already present in the repo:
  - `require "module.path"`
  - `local map = vim.keymap.set` for keymaps
  - plugin specs as Lua tables returned from `lua/plugins/init.lua`
- Prefer extending existing config files over creating new top-level patterns.
- Keep lockfile changes intentional: do not edit `lazy-lock.json` manually.

## Build and Deployment

There is no compile/build artifact.

Deployment for this repo means installing/updating it at Neovim’s config path (`~/.config/nvim`) and syncing plugins.

Recommended update flow:

```bash
git pull
nvim --headless '+Lazy! sync' '+qa'
```

## Security Considerations

- Do not commit secrets, API tokens, or machine-specific credentials in Lua files.
- Prefer environment variables or local, untracked files for sensitive values.
- Be careful with keymaps/autocmds that shell out; never execute untrusted input.

## Pull Request / Commit Guidance

Before opening a PR or merging:

1. Run smoke/health/plugin sync commands listed above.
2. Confirm `git status` is clean except for intentional changes.
3. Include `lazy-lock.json` in the same change when plugin versions are updated.

Observed commit style in this repo is short, imperative, and lowercase (for example: `update deps`, `add diffview.nvim plugin ...`).

## Debugging and Troubleshooting

### Config fails to start

Run:

```bash
nvim --headless '+qa'
```

Then inspect startup output with:

```bash
nvim -V1 -v
```

### Plugin issues after edits

Resync plugins:

```bash
nvim --headless '+Lazy! sync' '+qa'
```

### Environment sanity check

```bash
nvim --version
```

Current known-good local version used during AGENTS.md authoring: `NVIM v0.11.6`.
