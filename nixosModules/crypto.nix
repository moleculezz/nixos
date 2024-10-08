{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cryptsetup #LUKS setup
    yubikey-manager #FIDO2 setup
    trezor-suite #Crypto Wallet
    trezor-udev-rules
    trezorctl
  ];
}
