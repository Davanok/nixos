# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, globals, inputs, ... }:

{
  system.stateVersion = "26.05";

  imports = [
    ./hardware-configuration.nix
    ./modules/system/default.nix
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];

      auto-optimise-store = true;

#      substituters = [
#        "https://cache.nixos.org/"
#        "https://nix-community.cachix.org"
#      ];
      
#      trusted-public-keys = [
#        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
#      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 5;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
  };

  time.timeZone = "Europe/Moscow";

  networking.firewall = {
    enable = true;

    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];

    trustedInterfaces = [ "tun0" ];
    allowPing = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  nixpkgs.overlays = [
    (import ./overlays/osu.nix)
  ];
}

