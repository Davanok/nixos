{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    foot
    firefox
    telegram-desktop
    kdePackages.filelight
    orca-slicer
    nur.repos.wenjinnn.hiddify-next
  ];
}
