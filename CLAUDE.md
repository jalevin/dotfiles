# Dotfiles Overview

Jeff Levin's macOS dotfiles for a Staff Software Engineer at Grafana Labs.

## Repository Layout

```
dotfiles/
├── Makefile              # All setup targets
├── configs/              # All managed config files
│   ├── zshrc             # Shell config
│   ├── git/
│   │   ├── config        # Git config with aliases and SSH signing
│   │   └── ignore        # Global gitignore
│   ├── tmux/
│   │   └── tmux.conf     # Tmux config
│   ├── init.vim          # Neovim entry point
│   ├── lua/              # Neovim Lua config
│   ├── claude/           # Claude Code config
│   │   ├── settings.json # Permissions, statusline, agent definitions
│   │   ├── statusline.sh # Custom status line script
│   │   └── agents/       # Agent prompt files (default.md, github.md)
│   ├── hive/
│   │   └── config.yaml   # Hive workspace config (workspace: ~/projects)
│   ├── agent-deck-config.toml  # Agent Deck config
│   ├── xbar/             # xbar menu bar plugins
│   └── ...               # gemrc, sqliterc, op, vscode.vimrc
├── install/
│   ├── Brewfile          # Homebrew packages
│   └── macos             # macOS system defaults script
├── bin/                  # Personal scripts on PATH
├── fonts/                # TTF fonts
└── Support/              # macOS Application Support files
```

## Symlinks (`make link`)

All configs live in `dotfiles/configs/` and are symlinked into place — never edit files at their destination paths directly.

`make link` is idempotent and safe to re-run after adding new configs. The target directory structure mirrors the destination: folders under `configs/` that correspond to `~/.config/{tool}/` are symlinked as a whole directory where possible, rather than file-by-file.

Going forward, new configs should target `~/.config/{tool}/` (XDG Base Directory spec) rather than legacy dotfile locations (e.g. `~/.toolrc`). The XDG vars are exported in `zshrc` and defined in the Makefile.

## Key Configs

### Shell (`configs/zshrc`)

- **Editor**: `nvim` (aliased as `vim`; `vim` also aliased to `vi`)
- **Pager aliases**: `cat` → `bat`, `grep` → `rg`, `top` → `htop`
- **GOPATH**: `~/projects/go`; go binaries at `~/projects/go/bin`
- **Python**: managed via `pyenv`
- **Ruby**: managed via `rbenv`
- **Node**: pinned versions via `node18` / `node22` aliases; `pnpm` configured
- **Hive alias**: `hv` → opens/attaches tmux session named `hive` running `hive`

Notable aliases:
- `g` = `git`, `gm` = `git commit`, `gdiff` = `git --no-pager diff`
- `k` = `kubectl`, `gk` = Grafana kubectl wrapper
- `be` = `bundle exec`
- `rl` / `reload` = `source ~/.zshrc`
- `projects` = `cd ~/projects`

### Git (`configs/git/`)

- **User**: Jeff Levin `<jeff@levinology.com>`
- **Commit signing**: SSH via 1Password (`op-ssh-sign`)
- **Default branch**: `main`
- **Push**: `autoSetupRemote = true`
- **URL rewrites**: `https://github.com/` and `https://gitlab.com/` → SSH
- **Key aliases**: `ac` (add-all + commit), `lo` (log oneline), `fap` (fetch --all --prune), `rr` (reset to remote)

### Tmux (`configs/tmux/tmux.conf`)

- **Prefix**: `C-Space` / `C-q`
- **Mouse**: enabled
- **Vi copy mode**: `v` to select, `y` to copy, `r` for rectangle
- **Session shortcut**: `bind l` → switch to `hive` session

### Claude Code (`configs/claude/`)

**settings.json** defines:
- Pre-allowed Bash commands: `go get/run/test`, `git checkout/tag`, `ls`, `find`, `grep`, `jq`, `gh api/run/repo`
- Status line: runs `~/.claude/statusline.sh` (3-line display: model/cost/duration, context bar + git info, token breakdown)
- Enabled plugins: `typescript-lsp`, `gopls-lsp`, `agent-deck`
- Two agents: `default` (Grafana staff eng context) and `github` (minimal GitHub CLI auth rules)

**agents/default.md** system prompt context:
- Role: Staff Software Engineer at Grafana Labs
- Primary repos: `~/projects/deployment_tools` (Jsonnet/K8s infra), `~/projects/bench` (E2E testing)
- Tech stack: Golang, TypeScript, Kubernetes, Jsonnet
- GitHub access: always use `gh` CLI, never `curl`/WebFetch for GitHub URLs
- Commit style: no `Co-Authored-By` lines

### Hive (`configs/hive/config.yaml`)

Single workspace configured: `/Users/jeff/projects`

### Agent Deck (`configs/agent-deck-config.toml`)

- Default agent: `claude-code`
- Socket mode enabled (`use_sockets = true`)

## Setup / Maintenance

```bash
# First-time setup
make link         # Create all symlinks
make brew         # Install Homebrew packages from Brewfile
make install-fonts

# Update Brewfile after installing new packages
make brew-dump
```

The `make all` target runs `xcode`, `packages`, and `settings` — intended for fresh machine setup only.
