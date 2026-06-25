{ disks ? [ "/dev/nvme0n1" ], ... }:

{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = builtins.elemAt disks 0;
      
      content = {
        type = "gpt";
        
        partitions = {
          BOOT = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
              extraArgs = [ "-n" "BOOT" ];
            };
          };
          SWAP = {
            size = "16G";
            content = {
              type = "swap";
              randomEncryption = false;
              resumeDevice = false;
              extraArgs = [ "-L" "SWAP" ];
            };
          };
          ROOT = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-L" "ROOT" ];
              
              subvolumes = {
                "@root" = {
                  mountpoint = "/";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "@home" = {
                  mountpoint = "/home";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
              };
            };
          };
        };
      };
    };
  };
}
