{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lsd
    unzip
    btop
    exfatprogs # Add this to format drives with exFAT fs.
    amdgpu_top # Add this to check GPU usage stats.
    parted
  ];
}

