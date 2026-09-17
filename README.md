# dotfiles

Personal development environment configuration for macOS.

## Included Configs

| App | Description | Config |
|-----|-------------|--------|
| **opencode** | AI coding assistant | `config/opencode/` |
| **herdr** | TUI tool with keybindings | `config/herdr/config.toml` |
| **nvim** | NeoVim editor | `config/nvim/` |
| **zsh** | Shell setup | `shell/.zshrc`, `shell/.zprofile` |

## Quick Start

```bash
# Clone
git clone https://github.com/<username>/dotfiles.git && cd dotfiles

# Install (symlinks configs into place)
./install.sh
```

### Options

- `./install.sh --backup` — back up existing configs before replacing
- `./install.sh --force` — overwrite existing files
- `./install.sh --help` — show all options

## Updating Your Configs

Dotfiles use **symlinks**, so edits you make in `~/.config/...` are immediately reflected in the repo. Push changes with:

```bash
cd ~/dotfiles
git add .
git commit -m "Update config"
git push
```

## Structure

```
dotfiles/
├── install.sh            # Symlink installer
├── shell/                # Shell configs → ~/
├── config/               # App configs → ~/.config/
│   ├── opencode/
│   ├── herdr/
│   └── nvim/
└── README.md
```

## Keybindings (herdr)

| Key | Action |
|-----|--------|
| `Ctrl+A` | Command prefix (herdr) |

## Requirements

- macOS
- [Homebrew](https://brew.sh) (for zsh/brew setup)
- [Starship](https://starship.rs) prompt

## License

MIT