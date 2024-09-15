{pkgs, ...}:

let 
  installScript = pkgs.writeShellApplication {
    name = "install-local";

    runtimeInputs = with pkgs; [
      gitMinimal
    ];

    script = ''
      echo -n "Enter new encryption key: "
      read key

      echo -n "Enter WiFi SSID: "
      read ssid

      echo -n "Enter WiFi password: "
      read wifipass



      connect_wifi() {
        sudo systemctl start wpa_supplicant
        wpa_cli <<wpa_cli
add_network 0
set_network 0 ssid "$ssid"
set_network 0 psk "$wifipass"
enable_network 0
wpa_cli

      }

      create_encryption_file() {
        echo -n "$key" > /tmp/secret.key
      }

      install() {
        cd /tmp
        git clone https://github.com/moleculezz/nixos-config
        cd nixos-config
        git checkout kde-luks
        sudo nix run 'github:nix-community/disko#disko-install' -- --write-efi-boot-entries --flake '/tmp/nixos-config#gnix' --disk nvme /dev/nvme0n1
      }

      connect_wifi
      #create_encryption_file
      #install

    '';
  };
in {

  environment.systemPackages =
    (with pkgs; [
      gitMinimal
    ])
    ++ [ installScript ];

    nix.settings = {
      experimental-features = "nix-command flakes";
    };
}
