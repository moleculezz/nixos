{ pkgs, lib, config, inputs, userSettings, ... }:
{
  options.my = {
    hyprland.enable = 
      lib.mkEnableOption "Enable My Hyprland";
  };

  config = lib.mkIf config.my.hyprland.enable {

    # https://wiki.hyprland.org/Nix/Cachix/
    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };

    programs.hyprlock.enable = true;
    services.hypridle.enable = true;

    environment.systemPackages = with pkgs; [
      inputs.sddm-sugar-catppuccin.packages.${pkgs.system}.default
    ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    services.displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
      theme = "sugar-catppuccin";
    };

    home-manager.users.${userSettings.username} = {
      home.file.".config/hypr/hyprland.conf".source = ../../dotfiles/hyprland.conf;

      home.packages = with pkgs; [
        rofi-wayland
        cliphist
        swaynotificationcenter
      ];
    };
  };

}
