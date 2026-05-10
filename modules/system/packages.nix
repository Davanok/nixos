{ nixpkgs, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };


  imports = [
    ./packages/apps.nix
    ./packages/cli.nix
    ./packages/development.nix
    ./packages/fonts.nix
    ./packages/media.nix
    ./packages/system.nix
  ];
}
