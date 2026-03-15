# nixos

This repository contains my system configuration (`configuration.nix`), user configuration (`home.nix`), hardware configuration, and some application config files managed through flakes.

## Deploy on a Fresh Install

1. Install NixOS normally from the installer.

2. Clone this repository:

```bash
git clone https://github.com/z66n/nixos.git ~/dotfiles
```

3. Rebuild the system using the flake:

```bash
sudo nixos-rebuild switch --flake ~/dotfiles#nixos
```

This will apply the system configuration defined in the repository.

## Updating the System

After making changes to the configuration, run the rebuild command again

## Updating Inputs

To update flake dependencies:

```bash
nix flake update
```

Then rebuild with the same command

