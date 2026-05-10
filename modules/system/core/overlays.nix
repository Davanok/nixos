{ ... }:

{
  nixpkgs.overlays = [
    (import ../../../overlays/osu.nix)
  ];
}
