# dotfiles

A comprehensive dotfiles collection for my Arch Linux systems, featuring a
minimalist desktop environment with i3/Sway window managers and Neovim
configuration.

## Philosophy

This repository follows the principle of **symlink-based configuration
management** where dotfiles remain in the repository and are symbolically
linked to their target locations.
This approach ensures:

- **Version control**: My configurations are tracked and versioned
- **Portability**: Easy deployment across different machines
- **Modularity**: Granular control over which components to install

## Repository Structure

```
dotfiles/
├── Makefile              # Main deploy automation
├── files/                # System resources (fonts, package lists)
│   ├── *.ttf             # Custom fonts (NeoSpleen, ShareTech)
├── .config/              # config directory content
├── nvim/                 # Neovim configuration
├── i3/                   # i3 window manager configuration
├── sway/                 # Sway (Wayland) configuration
├── git/                  # Git configuration templates
├── scripts/              # Utility scripts
├── systemd/              # User systemd service definitions
└── weechat/              # IRC client
```


## Makefile Commands

The Makefile serves as the central orchestrator for system configuration:

### Base Installation Commands

| Command | Description | Dependencies |
|---------|-------------|--------------|
| `make all` | **Complete system setup** - Runs: check -> refresh_keys -> pkgs -> fonts -> dotfiles -> gpg -> ssh | None |
| `make check` | **Verify package manager availability** - Ensures yay/pacman is functional | Package manager |
| `make refresh_keys` | **Update Arch keyring** - Refreshes pacman GPG keys for package verification | pacman |
| `make pkgs` | **Install system packages** - Installs essential packages from `files/pkglist` | Package manager, keyring |
| `make fonts` | **Install custom fonts** - Copies TTF fonts to system directory and rebuilds font cache | Font files, fc-cache |

### General Configuration Commands

| Command | Description | Behavior |
|---------|-------------|----------|
| `make dotfiles` | **Deploy all configurations** - Runs: dot -> config -> i3 -> update | Existing configs backed up |
| `make dot` | **Link home directory dotfiles** - Symlinks .* files (excludes .config, .git*) | Creates symlinks to `$HOME` |
| `make config` | **Deploy .config directory** - Symlinks XDG config directories | Backs up existing configs to `~/devnull` |
| `make i3` | **Install window manager configs** - Links i3 and Sway configurations | Skipped on Raspberry Pi (`RPI=1`) |
| `make update` | **Refresh configurations** - Runs dotupdate.sh script | Updates existing symlinks |

### Identity

| Command | Description | Purpose |
|---------|-------------|---------|
| `make gpg` | **Import GPG public key** - Fetches from `github.com/fmount.gpg` | Code signing, encryption |
| `make ssh` | **Import SSH public keys** - Fetches from `github.com/fmount.keys` | Remote authentication |
| `make git` | **Configure Git identity** - Sets up Git profiles | Version control workflows |

### User Services

| Command | Description | Integration |
|---------|-------------|-------------|
| `make systemd` | **Install user systemd units** - Enables custom services | Background services, timers |
| `make email` | **Configure email client** - Sets up Neomutt with systemd integration | Requires email submodule |

### Testing

| Command | Description | Usage |
|---------|-------------|-------|
| `make test` | **Run repository tests** - Executes shellcheck via Podman | CI/CD validation |
| `make shellcheck` | **Lint shell scripts** - Static analysis of bash/shell code | Code quality assurance |
| `make help` | **Display command reference** - Lists all available targets with descriptions | Documentation |

## Customization Variables

The Makefile supports runtime customization through environment variables:

| Variable | Default | Purpose | Example |
|----------|---------|---------|---------|
| `PKG_MGR` | `yay` | Package manager selection | `make PKG_MGR=pacman pkgs` |
| `PKG_FLAGS` | `-Sy --noconfirm --needed` | Package manager options | `make PKG_FLAGS="" check` |
| `RPI` | `0` | Raspberry Pi mode (disables desktop components) | `make RPI=1 all` |
| `BACKUP_DIR` | `~/devnull` | Backup location for replaced configs | Automatic backup destination |

## Full System Setup

```bash
# Complete installation (recommended for new systems)
make all
```

## Selective Installation
```bash
# Install only essential packages
make check pkgs

# Deploy only dotfiles without system packages
make dotfiles

# Install fonts and window manager configs
make fonts i3
```

## Package Manager Override

```bash
# Use pacman instead of yay
make PKG_MGR=pacman PKG_FLAGS="" pkgs

# Raspberry Pi installation (no desktop components)
make RPI=1 all
```
