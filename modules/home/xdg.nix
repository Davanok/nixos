{ config, pkgs, ... }:

{
  xdg = {
    mimeApps.enable = true;
    configFile."mimeapps.list".enable = false;
    dataFile."applications/mimeapps.list".force = true;

    userDirs = {
      enable = true;
      download = "~/Downloads";
      pictures = "~/Pictures";
      desktop = "~/garbage";
      documents = "~/garbage";
      music = "~/garbage";
      publicShare = "~/garbage";
      templates = "~/garbage";
      videos = "~/garbage";
    };

    portal = {
      enable = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];

      config.common = {
        default = ["gtk" ];
      };
    };
  };
}
