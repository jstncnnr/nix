{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S6S1NG0R905246J";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "1025M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "@root" = {
                    mountpoint = "/";
                    mountOptions = ["compress=zstd"];
                  };

                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=zstd" "noatime"];
                  };

                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = ["compress=zstd"];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
