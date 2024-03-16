{ config, lib, pkgs, stylix, ... }:

{
  home.username = "gd";
  home.homeDirectory = "/home/gd";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    neofetch
    fzf # A command-line fuzzy finder
    firefox
    cinny-desktop
    rofi-wayland
  ];

  home.file.".config/hypr/hyprland.conf".source = ../configs/hyprland.conf;
  #home.file.".config/rofi/config.rasi".source = ../configs/rofi-config.rasi;
  #home.file.".config/rofi/default_theme.rasi".source = ../configs/rofi-theme.rasi;

  xresources.properties = {
    "Xcursor.size" = 24;
  };

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "GD";
    userEmail = "gd@wmc.io";
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };


  #stylix = {
  #  cursor.size = "48";
  #}; 

  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
