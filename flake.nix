{
  description = "Framework 13 AMD flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Disk manager
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    sddm-sugar-catppuccin = {
      url = "github:TiagoDamascena/sddm-sugar-catppuccin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";

    };
  };



  outputs = inputs@{ nixpkgs, nixos-hardware, disko, home-manager, stylix, ...}:

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
        nixos-hardware.nixosModules.framework-13-7040-amd
        ./nixos/configuration.nix
        
        disko.nixosModules.disko
        ./nixos/disko-configuration.nix

        stylix.nixosModules.stylix
        ./modules/stylix.nix

	home-manager.nixosModules.home-manager {
        home-manager.extraSpecialArgs = {
          inherit inputs;
        };
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        
        # TODO make username dynamic
        home-manager.users.gd = import ./home;

        }
        ];
      };
    };

  };
}
