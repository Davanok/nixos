{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    jq
    fzf
    zoxide
    _7zz-rar
    exiftool
    yazi
    
    wl-clipboard-rs
    cliphist

    sing-box
    platformio

    gcc
    tree
  ];
}
