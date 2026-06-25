{ nixpkgs, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };
  imports = [
    ./base-tools.nix
    ./desktop-wayland.nix
    ./coding.nix
    ./media-rendering.nix
    ./networking.nix
    ./fonts.nix
  ];
}
