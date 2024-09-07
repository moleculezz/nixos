{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pdfstudio2023 # NonFree pdf editor, similar to Acrobat
    vlc
  ];
}
