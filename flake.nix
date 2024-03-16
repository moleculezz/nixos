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

    sddm-sugar-catppuccin = {
      url = "github:TiagoDamascena/sddm-sugar-catppuccin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      #inputs.home-manager.follows = "home-manager";

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

        #stylix.nixosModules.stylix

        home-manager.nixosModules.home-manager {
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          # TODO make username dynamic
          home-manager.users.gd = import ./home;

          #stylix.image = pkgs.fetchurl {
          #  url = "https://raw.githubusercontent.com/moleculezz/dotfiles/main/wallpapers/beach-waves-starry-sky.jpg";
          #  sha256 = "cb13ae5913247a671fe91c241e339a17260d163a5b8e0cb616d19f143c30cc66";
          #};
          #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/zenburn.yaml";
        }
        ];
      };
    };

  };
}
