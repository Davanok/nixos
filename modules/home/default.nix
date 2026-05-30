{ pkgs, ... }:

{
  home.stateVersion = "26.05";
  
  imports = [
    ./programs/default.nix
    ./theme.nix
    ./wallpapers.nix
    ./xdg.nix
  ];
}
