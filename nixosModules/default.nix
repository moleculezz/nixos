{ config, pkgs, ... }:
{
  imports =
    [ 
      # Add styling & theming
      #./stylix.nix
      #./hyprland
      #./fonts
      ./utilities.nix
      ./office.nix
      ./multimedia.nix
      ./crypto.nix
      ./libvirt.nix
    ];
  }
