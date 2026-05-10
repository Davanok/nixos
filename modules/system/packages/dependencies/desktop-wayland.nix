{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    foot
    firefox
    telegram-desktop
    kdePackages.filelight
    xwayland-satellite
    yazi
    wl-clipboard-rs
    cliphist
    polkit_gnome
    brightnessctl
    playerctl
  ];
}
