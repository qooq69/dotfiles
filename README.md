# Dotfiles
My dotfiles managed by `GNU Make` and `GNU Stow`.

## Installation

The repo includes a Makefile that has few different targets. By default it symlinks everything.
```
$ git clone https://github.com/qooq69/dotfiles.git
$ cd dotfiles
$ make
```

### Available commands

- `make install` - same as `make`, symlinks all config files to their respective place
- `make config-headless` - minimal config intended for servers, raspberry pi, etc.
- `make config-minimal` - `config-headless` + basic GUI config
- `make uninstall` - removes all symlinks

### Scripts
There's additionally a script in `scripts` that does a basic setup. Requires Arch-based distro.
```
$ ./scripts/install.sh
```

## Software used

### GUI

| | Name | Package | Links |
|-| ---- | ------- | ----- |
| **Window Manager** | i3wm | `i3wm` <sup>[Arch](https://archlinux.org/packages/community/x86_64/i3-wm/)</sup> | [GitHub](https://github.com/i3/i3), [Docs](https://i3wm.org/docs/userguide.html)
| **Status Bar** | i3status-rust | `i3status-rust` <sup>[Arch](https://archlinux.org/packages/community/x86_64/i3status-rust/)</sup> | [GitHub](https://github.com/greshake/i3status-rust), [Docs](https://github.com/greshake/i3status-rust/wiki)
| **Compositor** | picom | `picom` <sup>[Arch](https://archlinux.org/packages/community/x86_64/picom/)</sup> | [GitHub](https://github.com/yshui/picom)
| **Application Launcher** | dmenu | `dmenu` <sup>[Arch](https://archlinux.org/packages/community/x86_64/dmenu/)</sup> | [Site](https://tools.suckless.org/dmenu/)


### CLI

| | Name | Package | Links |
|-| ---- | ------- | ----- |
| **Shell** | zsh | `zsh` <sup>[Arch](https://archlinux.org/packages/extra/x86_64/zsh/)</sup> | [Site](https://www.zsh.org/), [GitHub](https://github.com/zsh-users/zsh)
| **Terminal** | st | `st` <sup>[AUR](https://aur.archlinux.org/packages/st/)</sup> | [Site](https://st.suckless.org/)
| **Editor** | Neovim | `neovim` <sup>[Arch](https://archlinux.org/packages/community/x86_64/neovim/)</sup> | [GitHub](https://github.com/neovim/neovim), [Docs](https://github.com/neovim/neovim/wiki)
| **Music Player** | mpd | `mpd` <sup>[Arch](https://archlinux.org/packages/extra/x86_64/mpd/)</sup> | [Site](https://www.musicpd.org/), [Docs](https://mpd.readthedocs.io/en/latest/user.html)
| **MPD client** | ncmpcpp | `ncmpcpp` <sup>[Arch](https://archlinux.org/packages/community/x86_64/ncmpcpp/)</sup> | [GitHub](https://github.com/ncmpcpp/ncmpcpp)
