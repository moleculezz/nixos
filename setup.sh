#!/run/current-system/sw/bin/bash

#cd /tmp
#nix-shell -p git
#git clone https://github.com/moleculezz/nixos-config
#cd nixos-config
#git checkout kde-luks
#exit
#echo -n "Password" > /tmp/secret.key
sudo nix run 'github:nix-community/disko#disko-install' --experimental-features 'nix-command flakes' -- --write-efi-boot-entries --flake '/tmp/nixos-config#gnix' --disk nvme /dev/nvme0n1
sudo systemd-cryptenroll --fido2-device=auto --fido2-with-user-verification=true /dev/nvme0n1p3

