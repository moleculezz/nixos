{
  description = "Framework 13 AMD flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # Disk manager
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    }; 
  };



  outputs = inputs@{ self, nixpkgs, disko, home-manager, nixos-hardware, ... }:

  let 
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
    };

  in
  {

    nixosConfigurations = {
      gnix = nixpkgs.lib.nixosSystem {
        specialArgs = { 
	  inherit system;
          inherit inputs;
        };

        modules = [
        ./nixos/configuration.nix
        nixos-hardware.nixosModules.framework-13-7040-amd
        
        disko.nixosModules.disko
        ./nixos/disko-configuration.nix

        home-manager.nixosModules.home-manager {
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          # TODO make username dynamic
          home-manager.users.gd = import ./nixos;

        }
        ];
      };
    };

  };
}
