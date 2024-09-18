{
  description = "Framework 13 AMD flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    pdfstudio-fork.url = "github:daudi/nixpkgs/pdfstudio2024b";

    # Disk manager
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Hyprland
    #hyprland.url = "github:hyprwm/Hyprland";
    #hyprland-plugins = {
    #  url = "github:hyprwm/hyprland-plugins";
    #  inputs.hyprland.follows = "hyprland";
    #};

    #sddm-sugar-catppuccin = {
    #  url = "github:TiagoDamascena/sddm-sugar-catppuccin";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    #stylix = {
    #  url = "github:danth/stylix";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #  inputs.home-manager.follows = "home-manager";
    #};
  };



  outputs = { nixpkgs, nixos-hardware, disko, home-manager, pdfstudio-fork, ...}@inputs:

  let 
    systemSettings = {
      system = "x86_64-linux";
      hostname = "gnix";
    };

    userSettings = {
      username = "gd";
      name = "GD";
      homeDir = "/home/${userSettings.username}";
    };

    specialArgs = { inherit inputs; inherit systemSettings; inherit userSettings; };

    overlay-pdfstudio = final: prev: {
      fork = import pdfstudio-fork {
        localSystem = { system = systemSettings.system; };
        config.allowUnfree = true;
      };
    };

  in
  {

    nixosConfigurations = {
      gnix = nixpkgs.lib.nixosSystem {
        specialArgs = specialArgs;
        system = systemSettings.system;

        modules = [
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-pdfstudio ]; })
          ./hosts/gnix
        ];
      };
    };
  };
}
