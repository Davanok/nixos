{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    xwayland-satellite

    polkit_gnome

    brightnessctl
    playerctl

    fastfetch
    starship
  ];
}
