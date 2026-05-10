{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    jq
    fzf
    zoxide
    _7zz-rar
    exiftool
    gcc
    tree
    fastfetch
    starship
  ];
}
