{
  description = "Framework 13 AMD flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # Disk manager
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };



  outputs = { self, nixpkgs, disko, home-manager }:

  let 
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };

  in
  {

    nixosConfigurations = {
      gnix = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };

        modules = [
        ./nixos/configuration.nix
        disko.nixosModules.disko
        ./nixos/disko-configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          # TODO make username dynamic
          home-manager.users.gd = import ./nixos/home.nix;
        }
        ];
      };
    };

  };
}
