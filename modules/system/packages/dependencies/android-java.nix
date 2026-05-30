{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    android-studio-full
    android-tools
    platformio
    python313
  ];
}
