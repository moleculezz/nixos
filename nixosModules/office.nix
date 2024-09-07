{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libreoffice-qt-fresh # QT version for KDE
    pdfmixtool # OpenSource pdf merge/split tool
    xournalpp # OpenSource pdf editor, annotate
  ];
}
