{
  disko.devices = {
    disk = {
      nvme = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-SHPP41-1000GM_SJB6N503110206D1F";
        content = {
          type = "gpt";

          partitions = {
            boot = {
              size = "2048M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };

            swap = {
              size = "38G";
              content = {
                type = "swap";
                resumeDevice = true; # resume from hibernation from this device
              };
            };

            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "nvme0n1p3_encrypted";
                settings = {
                  allowDiscards = true;
                };
                #extraOpenArgs = [ "--allow-discards" ];
                passwordFile = "/tmp/secret.key";
                content = {
                  type = "zfs";
                  pool = "gnix";
                };
              };
            };
          };
        };
      };
    };

    zpool = {
      gnix = {
        type = "zpool";

        rootFsOptions = {
          mountpoint = "none";
          acltype = "posixacl";
          canmount = "off";
          dnodesize = "auto";
          relatime = "on";
          xattr = "sa";
        };

        options = {
          ashift = "12";
          autotrim = "on";
        };

        datasets = {
          root = {
            type = "zfs_fs";
            mountpoint = "/";
          };

          nix = {
            type = "zfs_fs";
            mountpoint = "/nix";
            options.mountpoint = "legacy";
          };

          var = {
            type = "zfs_fs";
            mountpoint = "/var";
            options.mountpoint = "legacy";
          };

          home = {
            type = "zfs_fs";
            mountpoint = "/home";
            options = {
              mountpoint = "legacy";
              "com.sun:auto-snapshot" = "true";
              compression = "lz4";
            };
          };
        };
      };
    };
  };
}
