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
              size = "1024M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/mnt/boot";
              };
            };
            swap = {
              size = "38G";
              content = {
                type = "swap";
                resumeDevice = true; # resume from hibernation from this device
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "lappool";
              };
            };
          };
        };
      };
    };
    zpool = {
      lappool = {
        type = "zpool";
        
        rootFsOptions = {
          mountpoint = "none";
          encryption = "aes-256-gcm";
          keyformat = "passphrase";
          keylocation = "prompt";
          acltype = "posixacl";
          canmount = "off";
          dnodesize = "auto";
          normalization = "formD";
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
            mountpoint = "/lappool/ROOT";
          };
          nix = {
            type = "zfs_fs";
            mountpoint = "/lappool/nix";
            options.mountpoint = "legacy";
          };
          var = {
            type = "zfs_fs";
            mountpoint = "/lappool/var";
            options.mountpoint = "legacy";
            
          };
          home = {
            type = "zfs_fs";
            mountpoint = "/lappool/home";
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
