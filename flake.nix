{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    disko.url = "github:nix-community/disko"
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };



  outputs = { self, nixpkgs, disko }:

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
        ];
      };
    };

  };
}
