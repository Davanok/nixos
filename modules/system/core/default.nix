{ ... }:

{
  imports = [
    ./state.nix
    ./nix.nix
    ./boot.nix
    ./localization.nix
    ./networking.nix
    ./overlays.nix
  ];
}
