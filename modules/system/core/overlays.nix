{ ... }:

{
  nixpkgs.overlays = [
    (import ../../../overlays/osu.nix)
    (import ../../../overlays/jetbra.nix)
  ];
}
