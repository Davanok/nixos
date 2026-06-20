{ ... }:

{
  nixpkgs.overlays = [
    (import ../../../overlays/osu.nix)
    (import ../../../overlays/jetbra.nix)
  ];

  imports = [
    ../../../packages/happ/happ-module.nix
  ];
}
