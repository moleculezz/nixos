#!/bin/sh

cd /tmp
nix-shell -p git
git clone https://github.com/moleculezz/nixos-config
cd nixos-config
git checkout kde-luks
exit
sudo nix run 'github:nix-community/disko#disko-install' --experimental-features 'nix-command flakes' -- --write-efi-boot-entries --flake '/tmp/nixos-config#gnix' --disk nvme /dev/nvme0n1

