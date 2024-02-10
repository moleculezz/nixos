{ pkgs, config, ...}:

{
  imports = [
    ./home.nix
    ./waybar.nix
  ];
}
