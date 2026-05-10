{ pkgs, ... }:

{
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    bibata-cursors
  ];
  
  imports = [
    ./programs/default.nix
    ./theme.nix
    ./wallpapers.nix
    ./xdg.nix
  ];
}
