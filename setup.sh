#!/run/current-system/sw/bin/bash

echo -n "Enter crypto password: "
read password

cd /tmp
nix run nixpkgs#git --experimental-features 'nix-command flakes' -- clone https://github.com/moleculezz/nixos-config
cd nixos-config
nix run nixpkgs#git --experimental-features 'nix-command flakes' -- checkout kde-luks
echo -n "$password" > /tmp/secret.key
#sudo nix run 'github:nix-community/disko#disko-install' --experimental-features 'nix-command flakes' -- --write-efi-boot-entries --flake '/tmp/nixos-config#gnix' --disk nvme /dev/nvme0n1
#sudo systemd-cryptenroll --fido2-device=auto /dev/nvme0n1p3

