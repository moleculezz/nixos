{ pkgs, ... }:

let
  theme = "catppuccin-macchiato";
  opacity = 0.95;
  font-size = 8;
in
{
  stylix.image = ../assets/beach-waves-starry-sky.jpg;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";

  stylix.opacity = {
    terminal = opacity;
    popups = opacity;
  };

  stylix.cursor = with pkgs; {
    package = phinger-cursors;
    name = "phinger-cursors";
    size = 24;
  };

  stylix.fonts = with pkgs; {
    serif = {
      package = noto-fonts;
      name = "Noto Serif";
    };

    sansSerif = {
      package = noto-fonts-cjk-sans;
      name = "Noto Sans CJK JP";
    };

    monospace = {
      package = jetbrains-mono;
      name = "JetBrains Mono";
    };

    emoji = {
      package = noto-fonts-emoji;
      name = "Noto Color Emoji";
    };

    sizes = {
      applications = font-size;
      desktop = font-size;
      popups = font-size;
      terminal = font-size;
    };
  };
}
