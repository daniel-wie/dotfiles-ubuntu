# Dotfiles Ubuntu 26.04

## About

This repo contains most of my configs, managed with `stow`.

## Install

All commands listed in the install section are intended to be run from the root of the
repository! First, create some directories

```
mkdir -p ~/.config
mkdir -p ~/.local/share
mkdir -p ~/.local/state
mkdir -p ~/.cache
mkdir -p ~/.ssh
```

Modify permissions for `.ssh`

```
chmod 700 ~/.ssh
```

Remove `snap` and all its artifacts by running
[`remove_snap.sh`](./scripts/remove_snap.sh).

Add repositories for `firefox`, `zotero`, and `teams-for-linux` using
[`repositories.sh`](./scripts/repositories.sh).

Install `apt` packages with `sudo apt-get install $(cat packages/apt.txt)` and manual ones
using

```
for p in packages/*.sh; do
    "./$p"
done
```

Remove some unneeded packages:

```
sudo apt-get remove --purge gnome-themes-extra-data pinentry-gnome3
sudo apt-get autoremove --purge
```

Set shell to `zsh` `chsh -s $(which zsh)` and `ZDOTDIR` with
`sudo ln -sf $(pwd)/etc/security/pam_env.conf /etc/security/pam_env.conf`.

Lastly, the repository [`home`](./home/) directory is symlinked to the actual home using
`stow home`.

## Maintenance and Updates

### Repositories:

```
sudo apt update
sudo apt upgrade
```

### neovim

Run [`10_nvim.sh`](./packages/10_nvim.sh) from shell and `:lua vim.pack.update()` from
`nvim`.

### Julia

Upgrade `Julia` itself using `juliaup up` and apps with
`julia -e 'using Pkg; Pkg.Apps.update()'`.

### uv

`uv self update`
