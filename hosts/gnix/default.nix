{ config, pkgs, inputs, disko, nixos-hardware, ... }:
{
  imports =
    [ 
      # Configure Framework 13 7040 AMD laptop specific config.
      nixos-hardware.nixosModules.framework-13-7040-amd

      # Configure disk partitioning
      disko.nixosModules.disko
      ./disk-configuration.nix

      # Other hardware specific config.
      ./hardware-configuration.nix

      ./configuration.nix
    ];
}
