{ pkgs, ... }:

{
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    bibata-cursors
  ];
  
  imports = [
    ./programs/niri/default.nix
    ./programs/yazi/default.nix
    ./programs/fish.nix
    ./programs/git.nix
    ./programs/foot.nix
    ./programs/vscode.nix
    ./theme.nix
    ./xdg.nix
    ./wallpapers.nix
  ];
}
